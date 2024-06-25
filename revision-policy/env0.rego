package env0

# METADATA
# title: requires approval for more than 5 planned resources
# description: require approval on more than 5 planned resources
pending[format(rego.metadata.rule())] {
	input.deploymentRequest.revision != 'requiresApproval-wflow-test'
}
