package env0

has_key(x, k) {
	_ = x[k]
}

# METADATA
# title: require approval on cost estimation
# description: require approval if cost estimation is returning any value on the plan
pending[format(rego.metadata.rule())] {
	has_key(input.costEstimation, "totalMonthlyCost")
	input.costEstimation.totalMonthlyCost > 100
}

# METADATA
# title: require 2 approvals
# description: At least 2 approvals must be given.
pending[format(rego.metadata.rule())] {
	count(input.approvers) < 2
}

# METADATA
# title: more than 2 approvals
# description: allow if two or more approvals are given.
allow[format(rego.metadata.rule())] {
	count(input.approvers) >= 2
	not has_key(input.costEstimation, "projectDiffTotalMonthlyCost")
}

# METADATA
# title: more than 2 approvals
# description: allow if two or more approvals are given.
allow[format(rego.metadata.rule())] {
	count(input.approvers) >= 2
	has_key(input.costEstimation, "projectDiffTotalMonthlyCost")
	input.costEstimation.projectDiffTotalMonthlyCost > 5
}

format(meta) := meta.description
