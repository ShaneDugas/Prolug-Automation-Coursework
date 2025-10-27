
!#bash/bin
i=0
while IFS= read -r name; do
  i=$((i+1))
  mkdir -p - "Unit $i - $name"
done <<'EOF'
Automation Tools Installation and Execution
Interacting with the Operating system
Making and Using inventories
Admin commands and one-offs
Environment and Local Variables in systems
Automating Docker Builds
Automating Docker environments
Automating K8s environments
Build and Deploy Linux systems
Harden Linux systems
Update and patch systems
Configure Network Devices
Remediating and Reporting on Drift
CI_CD Pipelines and Make_Buy_Adopt_Decisions
Troubleshooting_Testing 1
Troubleshooting_Testing 2
EOF
