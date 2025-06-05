## Tech Stack
- **Backend**: Rails 7.1.5 + Ruby 3.3.5
- **Database**: PostgreSQL
- **Frontend**: Bootstrap 5.3.3 (via CDN)
- **Styling**: SCSS/SASS (but main styling is inline in desks/index.html.erb)
- **Authentication**: Devise
- **JS Framework**: Stimulus + Turbo Rails

## Fonts
- **Currently using**: Inter (from Google Fonts, inline)
- **Available in SCSS**: Work Sans (body), Nunito (headers)
- **Source**: Google Fonts

## Color Schema (from desks/index.html.erb)
- **Background**: `#181818` (dark)
- **Cards/Navbar**: `#222` (darker gray)
- **Accent/Buttons**: `#26c6da` (cyan/turquoise)
- **Text**: `#e9e9e9` (light gray)
- **Footer text**: `#888` (medium gray)
- **Nav links**: `#ccc` (hover: `#fff`)

## Available SCSS Colors (unused currently)
- Red `#FD1015`
- Blue `#0D6EFD` 
- Yellow `#FFC65A`
- Orange `#E67E22`
- Green `#1EDD88`

## Key Design Elements
- **Theme**: Dark mode with modern card design
- **Card hover effects**: `translateY(-4px) scale(1.03)`
- **Rounded forms**: `border-radius: 2rem`
- **Box shadows**: `0 2px 12px rgba(0,0,0,0.12)`
- **Logo**: Circular image with brand text
- **Layout**: Bootstrap grid system

## Current Structure
- **Root route**: `desks#index` (main homepage)
- **Styling approach**: Inline CSS in view file (not using SCSS files)
- **Brand**: "Desk Array"
