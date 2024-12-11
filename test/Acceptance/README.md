
# Acceptance Tests

Acceptance tests verify the behavior of QuarkBuilder with human-digestible tests.

## For QuarkBuilder changes, re-gen via:

```sh
legend-scripts> FOUNDRY_PROFILE=ir forge build
```

Then in `tests/Acceptance/` run:

```sh
legend-scriptstests/Acceptance> swift run Geno ../../out/QuarkBuilder.sol/QuarkBuilder.json --outDir ./Sources/Acceptance/ && swiftformat ./Sources/Acceptance/QuarkBuilder.swift
```

## Running Tests

```sh
legend-scriptstests/Acceptance> swift test
```

## Example Test

```swift
AcceptanceTest(
    name: "Alice transfers 10 USDC to Bob on Ethereum",
    given: [.tokenBalance(.alice, (100, .usdc), .ethereum)],
    when: .transfer(from: .alice, to: .bob, amount: (10, .usdc), on: .ethereum),
    expect: .revert(.notUnwrappable)
)
```
