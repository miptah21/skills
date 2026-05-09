# Icon Libraries Integration Guide

> Extracted from SKILL.md — loaded when user requests AWS/cloud architecture diagrams with icons.

## When User Requests Icons

**If user asks for AWS/cloud architecture diagrams with specific icons:**

1. **Check if library exists**: Look for `libraries/<library-name>/reference.md`
2. **If library exists**: Use Python scripts (see workflow below)
3. **If library does NOT exist**: Respond with setup instructions

### User Setup Instructions

**Step 1: Create Library Directory**
```bash
mkdir -p skills/excalidraw-diagram-generator/libraries/aws-architecture-icons
```

**Step 2: Download Library**
- Visit: https://libraries.excalidraw.com/
- Search for your desired icon set (e.g., "AWS Architecture Icons")
- Download the `.excalidrawlib` file

**Step 3: Place and Split Library**
```bash
python skills/excalidraw-diagram-generator/scripts/split-excalidraw-library.py \
  skills/excalidraw-diagram-generator/libraries/aws-architecture-icons/
```

**Step 4: Verify Structure**
```
libraries/aws-architecture-icons/
  aws-architecture-icons.excalidrawlib  (original)
  reference.md                          (generated — icon lookup table)
  icons/                                (generated — individual icon files)
    API-Gateway.json
    EC2.json
    Lambda.json
    ...
```

## Python Script Workflow (Recommended)

```bash
# Step 1: Create base diagram file with title
# (Create .excalidraw file with initial elements)

# Step 2: Add icons with labels
python scripts/add-icon-to-diagram.py my-diagram.excalidraw EC2 400 300 --label "Web Server"
python scripts/add-icon-to-diagram.py my-diagram.excalidraw VPC 200 150

# Step 3: Add connecting arrows
python scripts/add-arrow.py my-diagram.excalidraw 250 200 300 250 --label "HTTPS"
python scripts/add-arrow.py my-diagram.excalidraw 300 300 400 300 --style dashed --color "#7950f2"
```

**Benefits:**
- ✅ No token consumption (icon JSON never enters AI context)
- ✅ Accurate coordinate transformations
- ✅ Automatic UUID generation
- ✅ Reliable and fast

## Manual Integration (Not Recommended)

Only if Python scripts unavailable:
1. Read `reference.md` — lists all available icons
2. Load specific icon JSON files (200-1000 lines each — high token cost)
3. Calculate bounding boxes and coordinate offsets
4. Generate unique IDs for all elements
5. Add arrows and labels

**Challenges:** High token consumption (~2000-5000 lines), complex math, ID collision risk.

## Fallback: No Icons Available

Create diagrams using basic shapes (rectangles, ellipses, arrows) with color coding and text labels.
