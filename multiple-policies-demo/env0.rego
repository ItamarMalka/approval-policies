package env0

has_key(x, k) {
	_ = x[k]
}

# METADATA
# title: require multiple approvals when cost diffrence is large
# description: require approval if cost diffrence is larger then our given threshold and less then 2 approvals given.
pending[format(rego.metadata.rule())] {
	has_key(input.costEstimation, "projectDiffTotalMonthlyCost")
	input.costEstimation.projectDiffTotalMonthlyCost > 5
	count(input.approvers) < 2
}

# METADATA
# title: no diffrence in cost for deployment
# description: allow if there is no cost diffrence for this deployment.
allow[format(rego.metadata.rule())] {
	not has_key(input.costEstimation, "projectDiffTotalMonthlyCost")
}

# METADATA
# title: multiple approvals given for cost diffrence greater then threshold.
# description: allow if two or more approvals are given and the cost diffrence is greater then our threshold.
allow[format(rego.metadata.rule())] {
	has_key(input.costEstimation, "projectDiffTotalMonthlyCost")
	input.costEstimation.projectDiffTotalMonthlyCost > 5
	count(input.approvers) >= 2
}

# METADATA
# title: cost diffrence is smaller then threshold
# description: allow if cost diffrence is smaller then threshold.
allow[format(rego.metadata.rule())] {
	has_key(input.costEstimation, "projectDiffTotalMonthlyCost")
	input.costEstimation.projectDiffTotalMonthlyCost <= 5
}

format(meta) := meta.description
