# Tests

This document outlines the testing procedures for the Aipress24 project. We use a combination of unit, integration, and end-to-end tests to ensure code quality and reliability.

## Test organisation (tiers)

Python tests live under `tests/` and are split into three tiers, run in order and increasingly close to a real environment:

- **`tests/a_unit`** — fast, isolated unit tests. The `db_session` fixture yields `None`: these tests do not touch a database.
- **`tests/b_integration`** — integration tests running inside a **savepoint** (nested transaction) that is rolled back after each test, so they share a fast, always-clean database without committing.
- **`tests/c_e2e`** — end-to-end tests using a **committing** Flask test client against a fresh (drop/create) in-memory database (the `fresh_db` / `logged_in_client` / `make_authenticated_client` fixtures). These exercise real request → commit → teardown behaviour.

Tests must clean up after themselves: a tier must leave the database in the state the next tier expects.

The suite runs against **both SQLite** (default, fast) and **PostgreSQL** — see `make test-sqlite` / `make test-postgres`.

Browser-based end-to-end tests (Playwright) live under `e2e_playwright/` and run against a running server (see below).

## Prerequisites

Before running tests, ensure you have installed the necessary dependencies, including testing tools, as described in the [Getting Started / Installation](https://github.com/aipress24/aipress24#getting-started--installation) section of the README. This typically involves running:

```bash
make develop
make fake # if needed to generate fake data
```

## Running Tests

The `Makefile` provides convenient shortcuts for various testing tasks. You can view all available testing commands by running:

```bash
make help
```

Here's a breakdown of the most common testing scenarios:

### Unit and Integration Tests

These tests are executed using `pytest` and cover individual components (unit tests) and their interactions (integration tests).

*   **Run all tests (unit and integration):**

    ```bash
    make test
    ```
    or
    ```bash
    pytest
    ```

*   **Run tests in random order (helps detect order-dependent issues):**

    ```bash
    make test-randomly
    ```

*   **Run tests with coverage report:**

    ```bash
    make test-with-coverage
    ```
    or
    ```bash
    pytest --cov=aipress24
    ```

*   **Run tests with runtime type checking (using `typeguard`):**

    ```bash
    make test-with-typeguard
    ```
    or
    ```bash
    pytest --typeguard-packages=aipress24
    ```

* **Run tests with runtime type checking (using `beartype`):**

    ```bash
    make test-with-beartype
    ```
    or
    ```bash
    BEARTYPE_ENABLED=True pytest
    ```

### Linting and Static Analysis

Before running tests, it's highly recommended to run linters and static analysis to catch potential issues early.

```bash
make lint
```
or:
```bash
nox -s lint
```

### End-to-End Tests

End-to-end tests simulate user interactions with the application and verify that the entire system works as expected.

```shell
pytest -vvv --browser firefox --video on --headed e2e_playwright
```

More information in the `tests-e2e` directory.

### Nox Integration Tests

**Nox** is a powerful tool for automating tests in multiple environments. It uses a `noxfile.py` configuration file to define various testing sessions.

Nox sessions are shown by `nox -l`:

```
* test-3.12
* test-3.11
* test-3.10
* lint
- check_prod
```

*   `test-3.12`, `test-3.11`, `test-3.10`: These sessions run the test suite (using `pytest`) against Python 3.12, 3.11 and 3.10 respectively. This ensures that the code is compatible with different Python versions.
*   `lint`: This session runs linters and static analysis tools (e.g., `ruff`, `mypy`) to check code quality and catch potential errors, as configured in the `noxfile.py`
*   `check_prod`: This session checks the code for production readiness.

To run a specific Nox session, use `nox -s <session_name>`. For example:

```bash
nox -s test-3.12  # Run tests with Python 3.12
nox -s lint       # Run linters
```

Running `nox` without the `-s` flag will execute all sessions marked with a star `*` by default, in this case the tests against all supported Python versions.

## Continuous Integration

CI runs primarily on **GitHub Actions** (`.github/workflows/`):

- `ci.yml` / `tests.yml` — run the test suite and checks on every push / pull request.
- `lint.yml` — runs the lint and static-analysis gates (`ruff`, type checkers, import-linting…).
- `fly-deploy.yml` — deploys the application to **Fly.io**.

Historically, **SourceHut** builds (`.builds/`) were also used, generated from a GitHub mirror. The use of `uv` and `nox` in CI mirrors the recommended local development and testing workflow.

## Notes

*   The `Makefile` shortcuts are recommended for ease of use and consistency.
*   Ensure your development environment is properly set up before running tests (see the "Development Environment" section in the README).
*   When contributing code, please make sure to add appropriate unit and integration tests to cover your changes.
