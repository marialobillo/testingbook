Feature: code-breaker submits guess

  The code-breaker submits a guess of four numbers. The game marks the guess
  with + and - signs.

  For each number in the guess that matches the number and position of a number
  in the secret code, the mark includes one + sign. For each number in the guess
  that matches the number but not the position of a number in the secret code,
  the mark includes one - sign.

  As a code-breaker
  I want to submit a guess
  So that I can try to break the code

  Scenario: all exact matches
    Given the secret code is '1234'
    When I guess '1234'
    Then the mark should be '++++'

  Scenario: 2 exact matches and 2 number matches
    Given the secret code is '1234'
    When I guess '1234'
    Then the mark should be '++--'

  Scenario: 1 exact match and 3 number matches
    Given the secret code is '1234'
    When I guess '1342'
    Then the mark should be '+---'

  Scenario: 4 number matches
    Given the secret code is '1234'
    When I guess '4321'
    Then the mark should be '----'

  Scenario Outline: submit guess
    Given the secret code is "<code>"
    When I guess "<guess>"
    Then the mark should be "<mark>"

    Scenarios: no matches
      | code | guess | mark |
      |1234  | 5555  |      |

    Scenarios: 1 number correct
      | code | guess | mark |
      |1234  | 1555  | +    |
      |1234  | 2555  | -    |

    Scenarios: 2 numbers correct
      | code | guess | mark |
      |1234  | 5254  | ++   |
      |1234  | 5154  | +-   |
      | 1234 | 2545  | --   |

    Scenarios: 3 numbers correct
      | code | guess | mark |
      |1234|5234 |+++ |
      |1234|5134 |++- |
      |1234|5124 |+-- |
      |1234|5123 |--- |

    Scenarios: all numbers correct
      | code | guess | mark |
      |1234|1234 |++++|
      |1234|1243 |++--|
      |1234|1423 |+---|
      |1234|4321 |----|
