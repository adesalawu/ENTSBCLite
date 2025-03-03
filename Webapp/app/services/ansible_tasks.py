import subprocess

def run_ansible_playbook(playbook: str, extra_vars: dict):
    cmd = [
        "ansible-playbook",
        f"ansible/playbooks/{playbook}",
        "--extra-vars",
        str(extra_vars)
    ]
    result = subprocess.run(cmd, capture_output=True)
    if result.returncode != 0:
        raise Exception(f"Ansible Playbook failed: {result.stderr}")
    return result.stdout
