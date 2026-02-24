#!/usr/bin/env python3
"""
Tavily Search - Web search using Tavily AI API
"""

import os
import sys
import json
import urllib.request
import urllib.error

# Get API key from environment or config
API_KEY = os.environ.get('TAVILY_API_KEY', '')
if not API_KEY:
    print(json.dumps({
        "error": "TAVILY_API_KEY not set. Get your key at https://tavily.com"
    }, indent=2))
    sys.exit(1)

def search(query, max_results=5, search_depth="basic", include_answer=False):
    """Search using Tavily API"""
    
    url = "https://api.tavily.com/search"
    
    payload = {
        "api_key": API_KEY,
        "query": query,
        "max_results": min(max_results, 10),
        "search_depth": search_depth,  # "basic" or "advanced"
        "include_answer": include_answer,  # AI-generated answer
        "include_raw_content": False,
    }
    
    headers = {
        "Content-Type": "application/json"
    }
    
    try:
        req = urllib.request.Request(
            url,
            data=json.dumps(payload).encode('utf-8'),
            headers=headers,
            method='POST'
        )
        
        with urllib.request.urlopen(req, timeout=30) as response:
            result = json.loads(response.read().decode('utf-8'))
            return result
            
    except urllib.error.HTTPError as e:
        return {"error": f"HTTP {e.code}: {e.reason}"}
    except Exception as e:
        return {"error": str(e)}

if __name__ == "__main__":
    # Parse arguments
    if len(sys.argv) > 1:
        query = sys.argv[1]
    else:
        query = sys.stdin.read().strip()
    
    if not query:
        print(json.dumps({"error": "No query provided"}, indent=2))
        sys.exit(1)
    
    # Parse optional parameters from query string
    max_results = 5
    search_depth = "basic"
    include_answer = True
    
    # Check for parameter hints in query
    if "--advanced" in query:
        search_depth = "advanced"
        query = query.replace("--advanced", "").strip()
    
    result = search(query, max_results, search_depth, include_answer)
    print(json.dumps(result, indent=2))
