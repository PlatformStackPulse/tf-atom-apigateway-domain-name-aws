# Unit Tests for tf-atom-apigateway-domain-name-aws
#
# These tests use a mock AWS provider — no real AWS calls are made.
# All assertions are on values that are KNOWN at plan time (the tf-label
# `id` string, the `enabled` flag, and normalized tags) so they do not
# depend on computed attributes that a mock provider leaves unknown.
#
# Run with:        terraform test -test-directory=tests/unit
# Run verbose:     terraform test -test-directory=tests/unit -verbose

mock_provider "aws" {}

# Standard tf-label inputs shared by every run block.
variables {
  namespace = "eg"
  stage     = "test"
  name      = "thing"
}

# ---------------------------------------------------------------------------
# Test: module is enabled by default and produces a well-formed tf-label ID
# ---------------------------------------------------------------------------
run "creates_when_enabled" {
  command = plan

  assert {
    condition     = output.enabled == true
    error_message = "Module should be enabled by default (enabled output must be true)."
  }

  assert {
    condition     = output.id == "eg-test-thing"
    error_message = "tf-label ID should be composed from namespace-stage-name ('eg-test-thing')."
  }

  assert {
    condition     = output.tags["Name"] == "eg-test-thing"
    error_message = "Normalized tags should include a Name tag equal to the tf-label ID."
  }
}

# ---------------------------------------------------------------------------
# Test: setting enabled = false disables the module (no resources created)
# ---------------------------------------------------------------------------
run "disabled_creates_nothing" {
  command = plan

  variables {
    enabled = false
  }

  assert {
    condition     = output.enabled == false
    error_message = "When enabled = false the enabled output must be false."
  }

  assert {
    condition     = output.id == ""
    error_message = "When disabled, tf-label produces an empty ID string (no resources named)."
  }
}
