# Tavily Search Skill

## Overview

AI-powered web search using Tavily API. Optimized for LLMs with AI-generated answers and source citations.

## Setup

✅ **Already configured** with your API key.

## Usage

### Direct tool call:
```
!tavily_search(query="your search query", max_results=5)
```

### Natural language:
Just ask me to search for something:
```
Search for latest AI news
```
```
Find information about climate change
```

## Features

- **AI-generated answers** - Summarized responses with sources
- **Search depth** - Basic or advanced search modes
- **Up to 10 results** - Configurable result count
- **Fast response** - Typically under 2 seconds

## API Key

Stored in: `~/.openclaw/.env`

Get your own key at: https://tavily.com

## Files

- `search.py` - Search implementation
- `skill.yml` - OpenClaw tool registration
- `SKILL.md` - Documentation
