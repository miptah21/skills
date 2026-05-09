import sys, os, json, re

def main():
    if len(sys.argv) < 2:
        print("Usage: python analyze.py <file_or_directory>", file=sys.stderr)
        sys.exit(1)
        
    target = sys.argv[1]
    issues = []
    warnings = []
    
    def analyze_html(filepath):
        print(f"Analyzing: {filepath}", file=sys.stderr)
        try:
            with open(filepath, "r", encoding="utf-8", errors="ignore") as f:
                content = f.read().lower()
                
            if "<!doctype html>" not in content:
                issues.append(f"{filepath}: Missing HTML5 doctype")
            if "charset=utf-8" not in content and "charset=\"utf-8\"" not in content:
                warnings.append(f"{filepath}: Missing or non-UTF-8 charset declaration")
            if "name=\"viewport\"" not in content:
                issues.append(f"{filepath}: Missing viewport meta tag")
            if "<html" in content and "lang=" not in content.split(">", 1)[0]:
                issues.append(f"{filepath}: Missing lang attribute on <html>")
            if "<title>" not in content:
                issues.append(f"{filepath}: Missing <title> tag")
            if "http://" in content:
                warnings.append(f"{filepath}: Contains non-HTTPS URLs")
        except Exception as e:
            print(f"Error reading {filepath}: {e}", file=sys.stderr)

    if os.path.isdir(target):
        for root, _, files in os.walk(target):
            for file in files:
                if file.endswith(".html") or file.endswith(".htm"):
                    analyze_html(os.path.join(root, file))
    elif os.path.isfile(target):
        analyze_html(target)
        
    print(json.dumps({
        "issues": issues,
        "warnings": warnings,
        "issueCount": len(issues),
        "warningCount": len(warnings)
    }, indent=2))

if __name__ == "__main__":
    main()
