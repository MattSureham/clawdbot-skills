# clawdbot-skills

Custom Clawdbot skills. Add more skills here!

## Available Skills

### star-gazer
Track GitHub repositories with the most star gains.

**Usage:**
```bash
export GITHUB_TOKEN="your_token"
clawdbot exec --command "bash /path/to/star-gazer.sh"
```

**With dry-run:**
```bash
./star-gazer.sh --dry-run
```

## Adding New Skills

1. Create a folder: `skills/<skill-name>/`
2. Add `SKILL.md` with documentation
3. Add executable scripts
4. Submit a PR or push directly

## License

MIT
