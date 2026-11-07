# Domain Docs

How the engineering skills should consume and maintain BookPasal's domain documentation.

## Locations

- **Glossary & ADRs**: `bookpasal-tracker/docs/`
  - `bookpasal-tracker/docs/GLOSSARY.md`: Canonical business & domain vocabulary
  - `bookpasal-tracker/docs/adr/`: Architecture Decision Records

## Consumption Rules

1. Before starting a ticket or exploring code, read `bookpasal-tracker/docs/` for relevant domain terms and ADRs.
2. Use the vocabulary defined in `GLOSSARY.md` (Nepal context: NPR currency, Nepali phone number formats, addresses, book conditions, roles).
3. If a decision or term is missing or changes during interview/spec, update `bookpasal-tracker/docs/` inline.
4. If an existing ADR is contradicted, surface it immediately rather than silently overriding.

