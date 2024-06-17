# Tests

## Unit tests

```bash
pytest src
```

## Integration tests

```bash
pytests tests/integration
```

## End-to-end tests

```bash
# First, start the server, for instance with:
make run
# Then (in another window):
pytest -vvv --browser firefox --video on --headed e2e_playwright
```
