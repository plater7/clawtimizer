# Contributing to Clawtimizer

Thank you for your interest in contributing! 🎉

## Ways to Contribute

- 🐛 **Bug reports** — Open an issue with reproduction steps
- 💡 **Feature requests** — Open an issue with use case description
- 🔧 **Code improvements** — Submit a pull request
- 📚 **Documentation** — Fix typos, add examples, improve clarity

## Development Setup

```bash
# Clone the repository
git clone https://github.com/plater7/clawtimizer.git
cd clawtimizer

# Run shellcheck on the script (recommended)
shellcheck scripts/optimize.sh
```

## Pull Request Process

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Run shellcheck: `shellcheck scripts/optimize.sh`
5. Commit your changes with clear messages
6. Push to your fork and open a PR

## Adding New Models

To add support for a new model:

1. Edit `scripts/optimize.sh` to add the model to the supported list
2. Update `README.md` with the new model option
3. Update `SKILL.md` with the new model option
4. Test with: `OPTIMIZER_MODEL="your/model" bash scripts/optimize.sh`

## Code Style

- Use `set -euo pipefail` in bash scripts
- Prefer `[[ ]]` over `[ ]` for tests
- Quote all variables: `"$VAR"` not `$VAR`
- Use meaningful variable names
- Add comments for complex logic

## Questions?

Open an issue or start a discussion on GitHub!

---

<div align="center">

🤖 This project welcomes AI-assisted contributions.

</div>
