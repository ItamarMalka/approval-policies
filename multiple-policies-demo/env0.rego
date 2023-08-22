package env0

cost_threshold := 100
resource_limit := 5
required_approvers := 2

has_key(x, k) {
	_ = x[k]
}

# METADATA
# title: require multiple approvals when cost diffrence is large
# description: require approval if cost diffrence is larger then our given threshold and less then 2 approvals given.
pending[format(rego.metadata.rule())] {
	has_key(input.costEstimation, "monthlyCostDiff")
	input.costEstimation.monthlyCostDiff > cost_threshold
	count(input.approvers) < required_approvers
}

# METADATA
# title: multiple approvals given for cost diffrence greater then threshold.
# description: allow if two or more approvals are given and the cost diffrence is greater then our threshold.
allow[format(rego.metadata.rule())] {
	count(input.approvers) >= required_approvers
}

# METADATA
# title: cost diffrence is smaller then threshold
# description: allow if cost diffrence is smaller then threshold.
allow[format(rego.metadata.rule())] {
	has_key(input.costEstimation, "monthlyCostDiff")
	input.costEstimation.monthlyCostDiff <= cost_threshold
}

format(meta) := meta.description
