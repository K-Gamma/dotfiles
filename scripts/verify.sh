#!/usr/bin/env bash

set -euo pipefail

readonly repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
readonly override_data='{"useBitwarden":false}'
readonly temp_dir="$(mktemp -d)"

cleanup() {
  rm -rf "${temp_dir}"
}
trap cleanup EXIT

for command_name in chezmoi zsh shellcheck; do
  if ! command -v "${command_name}" >/dev/null 2>&1; then
    printf 'required command not found: %s\n' "${command_name}" >&2
    exit 1
  fi
done

cd "${repo_root}"

printf '[verify] chezmoi dry-run\n'
chezmoi \
  --source "${repo_root}" \
  --destination "${temp_dir}/destination" \
  --override-data "${override_data}" \
  apply --dry-run --no-tty --exclude=scripts

printf '[verify] rendered zsh syntax\n'
chezmoi \
  --source "${repo_root}" \
  --override-data "${override_data}" \
  cat ~/.config/zsh/.zshrc >"${temp_dir}/zshrc"
zsh -n "${temp_dir}/zshrc"

printf '[verify] shellcheck\n'
shell_files=()
while IFS= read -r -d '' shell_file; do
  if [[ -f "${shell_file}" ]]; then
    shell_files+=("${shell_file}")
  fi
done < <(git ls-files -z 'home/private_dot_local/bin/executable_git-*')
shell_files+=(home/private_dot_config/herdr/plugins/fzf-git/executable_picker.sh)
shellcheck --severity=warning "${shell_files[@]}"

printf '[verify] all checks passed\n'
