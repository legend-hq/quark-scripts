@preconcurrency import Eth

let cometSupplyTests: [AcceptanceTest] = [
    .init(
        name: "Alice supplies 0.5 WETH to cUSDCv3 on Ethereum",
        given: [
            .tokenBalance(.alice, .amt(1.0, .weth), .ethereum),
            .quote(.basic),
        ],
        when: .payWith(
            currency: .weth,
            .cometSupply(from: .alice, market: .cusdcv3, amount: .amt(0.5, .weth), on: .ethereum)
        ),
        expect: .success(
            .single(
                .multicall([
                    .supplyToComet(
                        tokenAmount: .amt(0.5, .weth), market: .cusdcv3, network: .ethereum),
                    .quotePay(
                        payment: .amt(0.000025000000000062, .weth), payee: .stax, quote: .basic),
                ])
            )
        )
    ),
    // @skip: Alice cannot supply ETH to comet because Actions.cometSupply doesn't wrap ETH
    .init(
        name: "Alice supplies 0.5 ETH to cUSDCv3 on Ethereum",
        given: [
            .tokenBalance(.alice, .amt(1.0, .eth), .ethereum),
            .quote(.basic),
        ],
        when: .payWith(
            currency: .eth,
            .cometSupply(from: .alice, market: .cusdcv3, amount: .amt(0.5, .eth), on: .ethereum)
        ),
        expect: .success(
            .single(
                .multicall([
                    .supplyToComet(
                        tokenAmount: .amt(0.5, .eth), market: .cusdcv3, network: .ethereum),
                    .quotePay(payment: .amt(0.000025, .eth), payee: .stax, quote: .basic),
                ])
            )
        ),
        skip: true
    ),
    .init(
        name:
            "Alice supplies, but does not allow enough for quote pay (testCometSupplyInsufficientFunds)",
        given: [.quote(.basic)],
        when: .cometSupply(from: .alice, market: .cusdcv3, amount: .amt(2, .usdc), on: .ethereum),
        expect: .revert(
            .badInputInsufficientFunds(
                Token.usdc.symbol,
                TokenAmount.amt(2, .usdc).amount,
                TokenAmount.amt(0, .usdc).amount
            )
        )
    ),
    .init(
        name: "Alice supplies, but cannot cover operation cost (testCometSupplyMaxCostTooHigh)",
        given: [
            .tokenBalance(.alice, .amt(1.0, .usdc), .ethereum),
            .tokenBalance(.alice, .amt(1.0, .usdc), .base),
            .quote(
                .custom(
                    quoteId: Hex(
                        "0x00000000000000000000000000000000000000000000000000000000000000CC"),
                    prices: [Token.usdc: 1.0],
                    fees: [
                        .ethereum: 1000,
                        .base: 0.03,
                    ]
                )
            ),
        ],
        when: .payWith(
            currency: .usdc,
            .cometSupply(from: .alice, market: .cusdcv3, amount: .amt(1, .usdc), on: .ethereum)
        ),
        expect: .revert(
            .unableToConstructActionIntent(
                false,
                "",
                0,
                "IMPOSSIBLE_TO_CONSTRUCT",
                Token.usdc.symbol,
                TokenAmount.amt(1000.03001, .usdc).amount
            )
        )
    ),
    .init(
        name: "Alice supplies to Comet (testSimpleCometSupply)",
        given: [
            .tokenBalance(.alice, .amt(1.5, .usdc), .ethereum),
            .tokenBalance(.alice, .amt(1.5, .usdc), .base),
            .quote(.basic),
        ],
        when: .cometSupply(from: .alice, market: .cusdcv3, amount: .amt(1, .usdc), on: .ethereum),
        expect: .success(
            .single(
                .multicall([
                    .supplyToComet(
                        tokenAmount: .amt(1, .usdc), market: .cusdcv3, network: .ethereum),
                    .quotePay(payment: .amt(0.1, .usdc), payee: .stax, quote: .basic),
                ])
            )
        )
    ),
    .init(
        name: "Alice supplies max to Comet (testSimpleCometSupplyMax)",
        given: [
            .tokenBalance(.alice, .amt(3, .usdc), .ethereum),
            .quote(.basic),
        ],
        when: .cometSupply(from: .alice, market: .cusdcv3, amount: .max(.usdc), on: .ethereum),
        expect: .success(
            .single(
                .multicall([
                    .supplyToComet(
                        tokenAmount: .amt(2.9, .usdc), market: .cusdcv3, network: .ethereum),
                    .quotePay(payment: .amt(0.1, .usdc), payee: .stax, quote: .basic),
                ])
            )

        )
    ),
    .init(
        name: "Alice supplies max to Comet with bridge (testCometSupplyMaxWithBridgeAndQuotePay)",
        given: [
            .tokenBalance(.alice, .amt(50, .usdc), .arbitrum),
            .tokenBalance(.alice, .amt(50, .usdc), .base),
            .quote(.basic),
            .acrossQuote(.amt(1, .usdc), 0.01),
        ],
        when: .cometSupply(from: .alice, market: .cusdcv3, amount: .max(.usdc), on: .arbitrum),
        expect: .success(
            .multi([
                .bridge(
                    bridge: "Across",
                    srcNetwork: .base,
                    destinationNetwork: .arbitrum,
                    tokenAmount: .amt(50, .usdc)
                ),
                .multicall([
                    .supplyToComet(
                        tokenAmount: .amt(98.44, .usdc), market: .cusdcv3, network: .arbitrum),
                    .quotePay(payment: .amt(0.06, .usdc), payee: .stax, quote: .basic),
                ]),
            ])
        )
    ),
    .init(
        name: "Alice supplies to Comet, paying via Quote Pay (testCometSupplyWithQuotePay)",
        given: [
            .tokenBalance(.alice, .amt(1.5, .usdc), .ethereum),
            .tokenBalance(.alice, .amt(1.5, .usdc), .base),
            .quote(.basic),
        ],
        when: .cometSupply(from: .alice, market: .cusdcv3, amount: .amt(1, .usdc), on: .ethereum),
        expect: .success(
            .single(
                .multicall([
                    .supplyToComet(
                        tokenAmount: .amt(1, .usdc), market: .cusdcv3, network: .ethereum),
                    .quotePay(payment: .amt(0.1, .usdc), payee: .stax, quote: .basic),
                ])
            )

        )
    ),
]
