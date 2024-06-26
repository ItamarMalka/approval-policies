package env0

required_approvers := 2

# METADATA
# title: require multiple approvals when cost diffrence is large
# description: require approval if cost diffrence is larger then our given threshold and less then 2 approvals given.
pending[format(rego.metadata.rule())] {
	print("pending", input.costEstimation)
	has_key(input.costEstimation, "monthlyCostDiff")
	input.costEstimation.monthlyCostDiff > cost_threshold
	count(input.approvers) < required_approvers
}

# METADATA
# title: no diffrence in cost for deployment
# description: allow if there is no cost diffrence for this deployment.
allow[format(rego.metadata.rule())] {
	print("allow 1", input.costEstimation)
	not has_key(input.costEstimation, "monthlyCostDiff")
}

# METADATA
# title: multiple approvals given for cost diffrence greater then threshold.
# description: allow if two or more approvals are given and the cost diffrence is greater then our threshold.
allow[format(rego.metadata.rule())] {
	print("allow 2", input.costEstimation)
	has_key(input.costEstimation, "monthlyCostDiff")
	input.costEstimation.monthlyCostDiff > cost_threshold
	count(input.approvers) >= required_approvers
}

# METADATA
# title: cost diffrence is smaller then threshold
# description: allow if cost diffrence is smaller then threshold.
allow[format(rego.metadata.rule())] {
	print("allow 3", input.costEstimation)
	has_key(input.costEstimation, "monthlyCostDiff")
	input.costEstimation.monthlyCostDiff <= cost_threshold
}

format(meta) := meta.description
