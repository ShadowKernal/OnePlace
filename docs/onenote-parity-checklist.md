# OneNote Parity Master Fix List

This document replaces the earlier loose checklist with a full parity backlog.
The target is not "OneNote-inspired". The target is "as advanced as OneNote" wherever the platform and product scope make that practical.

## Target Standard

- Match Microsoft OneNote desktop behavior and information architecture by default.
- Treat visual likeness as insufficient unless the underlying interaction model, data model, and persistence also match.
- Do not ship ribbon commands that are only placeholders when the label implies real OneNote functionality.
- Every parity item must end with:
  - working UI behavior
  - persisted data model support
  - keyboard and pointer interaction coverage
  - regression coverage

## Current Reality

The app already resembles OneNote visually and includes a substantial baseline for notebooks, sections, pages, editor formatting, assets, search scopes, draw mode, and version snapshots.

The remaining gap is depth. Several controls are present but simplified, especially around:

- Outlook task workflows
- Dictation versus raw audio recording
- Copilot behavior
- full editor fidelity
- undo/redo depth
- drag/drop edge cases
- search depth and results quality
- review tools
- view controls
- collaboration and sync

## Release Principle

Do not treat parity as one milestone. Deliver it in ordered layers:

1. Core model parity
2. Navigation and hierarchy parity
3. Editor and layout parity
4. Desktop command parity
5. Advanced notebook features
6. Collaboration, sync, and resilience

Each layer below is a blocking dependency for the next one.

## Layer 1: Core Model Parity

### 1.1 Notebook schema

- [ ] Introduce a versioned domain schema for notebook, section group, section, page, subpage, outline container, attachment, ink, audio, task, tag, author, and sync metadata.
- [ ] Add stable IDs for every entity and every embedded object that OneNote treats as addressable.
- [ ] Separate persisted domain data from transient UI state.
- [ ] Add migration infrastructure for all future schema changes.
- [ ] Record created, updated, opened, modified, and sync timestamps independently.
- [ ] Add author metadata and device metadata to support future collaboration and conflict handling.

### 1.2 Page content model

- [ ] Replace the current HTML-first page storage with a structured page model that supports freeform containers, absolute positioning, z-order, and nested objects.
- [ ] Preserve imported HTML and pasted content without degrading layout on round-trip save.
- [ ] Model paragraphs, checklists, tables, files, images, printouts, audio, ink regions, links, and tags as first-class entities.
- [ ] Support mixed freeform layout: multiple note containers on the same page, not a single linear document only.
- [ ] Add per-object bounds, anchoring, and selection metadata.

### 1.3 Undo/redo foundation

- [ ] Implement multi-step transactional undo/redo across hierarchy changes, editor changes, tagging, assets, draw actions, and metadata edits.
- [ ] Group typing bursts into logical undo units.
- [ ] Preserve selection and scroll position across undo/redo.
- [ ] Make undo/redo durable across tab switches and ribbon commands.

## Layer 2: Hierarchy And Navigation Parity

### 2.1 Notebook surface

- [ ] Full notebook create, rename, recolor, duplicate, export, close, reopen, and delete flows.
- [ ] Recent notebooks list with pinned entries, last-opened recovery, and missing-path repair.
- [ ] Notebook switching behavior that matches OneNote selection memory.
- [ ] Notebook properties dialog with path, size, modified time, and sync status.

### 2.2 Section groups and sections

- [ ] Full create, rename, reorder, move, collapse, expand, and delete behavior for section groups.
- [ ] Full create, rename, recolor, reorder, move between groups, and delete behavior for sections.
- [ ] Locked section UX that matches OneNote more closely, including unlock timeout and relock controls.
- [ ] Section tabs with overflow handling, drag affordances, and scroll behavior aligned to OneNote.

### 2.3 Pages and subpages

- [ ] Page and subpage CRUD with exact promote, demote, reorder, collapse, and expand behavior.
- [ ] Selection recovery when collapsing parents with selected descendants.
- [ ] Drag/drop parity for before, after, and nesting targets with precise hit zones.
- [ ] Keyboard page movement and hierarchy manipulation shortcuts.
- [ ] Page templates at creation time, not only as insert-into-page content.
- [ ] Page previews, snippet generation, and search-hit highlighting in the page list.

### 2.4 Navigation polish

- [ ] Back/forward navigation stack for previously visited pages.
- [ ] "Recent pages" behavior closer to OneNote history semantics.
- [ ] Deep links to page, paragraph, or object when possible.
- [ ] Better focus management between notebook pane, section list, page list, and editor.

## Layer 3: Editor And Canvas Parity

### 3.1 Rich text fidelity

- [ ] Replace `document.execCommand` usage with a maintained editor model that supports deterministic formatting behavior.
- [ ] Preserve bold, italic, underline, highlight, font family, font size, alignment, lists, indentation, and links across save/load cycles.
- [ ] Match OneNote Enter, Shift+Enter, Tab, Shift+Tab, Backspace, Delete, and paste semantics.
- [ ] Support paragraph spacing, line spacing, and richer list behaviors.
- [ ] Add proper style presets instead of raw HTML insertion shortcuts.

### 3.2 Freeform note containers

- [ ] Support multiple independently movable note containers on a page.
- [ ] Allow clicking anywhere on the page canvas to create a text container at that position.
- [ ] Add resize handles and drag handles for text containers, images, files, printouts, and embedded media.
- [ ] Persist absolute positions and relative stacking.
- [ ] Add snap guides and collision-safe movement.

### 3.3 Tables

- [ ] Add insert row, delete row, insert column, delete column, resize, merge, split, and selection operations.
- [ ] Support tab navigation across cells.
- [ ] Preserve pasted table structure from Office and web sources with higher fidelity.
- [ ] Add contextual table commands in ribbon and context menus.

### 3.4 Paste and import fidelity

- [ ] Improve Word and Office HTML paste fidelity.
- [ ] Preserve links, lists, tables, colors, spacing, and embedded images more accurately.
- [ ] Add "keep source formatting" versus "merge formatting" strategies where feasible.
- [ ] Support web clipping and printout workflows.

### 3.5 Object interactions

- [ ] Make images movable, resizable, and captionable.
- [ ] Add attachment cards with open, save as, copy path, and remove commands.
- [ ] Improve printout rendering, pagination, and page anchoring.
- [ ] Add internal links to section, page, and paragraph targets where possible.

## Layer 4: Ribbon And Command Parity

### 4.1 File tab

- [ ] Real backstage-style file surface with notebook info, export, options, print, account, and recent notebooks.
- [ ] Open notebook directory and import notebook flows.
- [ ] Export single page, section, or notebook to supported formats.
- [ ] Print behavior and print preview equivalent for desktop builds.

### 4.2 Home tab

- [ ] Replace placeholder commands with real features.
- [ ] `To Do Tag` must use a typed tag system with searchability and status, not just prompt-based free-text tags.
- [ ] `Find Outlook Tasks` must become a real task panel and task query surface, not static text insertion.
- [ ] `Meeting Details` must open a meeting-data workflow or a structured template picker with attendee/date integration.
- [ ] `Dictate` must perform speech-to-text dictation into the note; audio recording should be separate.
- [ ] `Transcribe` must support converting recorded audio into inserted transcript blocks with timestamps when available.
- [ ] `Copilot` must either perform real note operations or be hidden until implemented.

### 4.3 Insert tab

- [ ] Expand insertion workflows for files, printouts, tables, links, dates, meeting details, page templates, symbols, and embedded media.
- [ ] Add better insertion placement logic for freeform pages.

### 4.4 Draw tab

- [ ] Add pen types, thicknesses, pressure handling, eraser modes, lasso select, and shape support.
- [ ] Support ink-to-text and ink-to-shape style transforms where feasible.
- [ ] Allow ink on the page canvas, not only a separate draw mode surface.
- [ ] Support mixed ink and text editing on the same page.

### 4.5 History tab

- [ ] Expand version history to include named snapshots, author attribution, diff metadata, and restore previews.
- [ ] Add page version browsing closer to OneNote page versions.
- [ ] Record page movement and structural edits in history where appropriate.

### 4.6 Review tab

- [ ] Implement spelling and grammar review.
- [ ] Add language and translation hooks if the product scope allows.
- [ ] Add find/replace that works across the current page and broader scopes.
- [ ] Add accessibility checks for page content where practical.

### 4.7 View tab

- [ ] Add zoom controls, page width modes, pane visibility toggles, and layout variations.
- [ ] Add dark mode and high-contrast support without breaking parity.
- [ ] Add page rule lines and visual guides if included in target parity scope.

## Layer 5: Search, Tags, Tasks, And Organization

### 5.1 Search

- [ ] Search by title, content, tag, task, attachment name, and optionally OCR content from printouts/images.
- [ ] Rank results by scope relevance, exact match, recent access, and object type.
- [ ] Highlight hits in page list and note canvas.
- [ ] Add keyboard navigation for search results.
- [ ] Add filter chips for notebooks, sections, tags, dates, and tasks.

### 5.2 Tag system

- [ ] Replace ad hoc page tag prompts with a typed tag catalog similar to OneNote tags.
- [ ] Support built-in tags and custom tags.
- [ ] Add tag summaries and tag search.
- [ ] Allow tagging paragraphs or objects, not just whole pages.
- [ ] Add tag completion and follow-up workflows.

### 5.3 Task system

- [ ] Build a real task aggregation layer.
- [ ] Support due dates, completion state, reminder metadata, and source-note linking.
- [ ] Add a task pane for all open tasks across scopes.
- [ ] Integrate email and meeting workflows into tasks where appropriate.
- [ ] If Outlook integration is out of scope, rename the feature clearly instead of implying Outlook parity.

## Layer 6: Audio, Dictation, And Transcription Parity

### 6.1 Audio recording

- [ ] Keep audio recording as its own feature, separate from dictation.
- [ ] Allow recording controls in-page with duration, device selection, pause/resume, and playback.
- [ ] Anchor recordings to page positions and note containers.

### 6.2 Dictation

- [ ] Stream recognized speech directly into the active note insertion point.
- [ ] Preserve punctuation and sentence segmentation.
- [ ] Show recording and recognition state in the UI.
- [ ] Recover cleanly from denied permissions and partial availability.

### 6.3 Transcription

- [ ] Allow transcription of inserted audio notes, not just live speech capture.
- [ ] Insert transcript blocks linked to audio.
- [ ] Support partial transcripts, retry flows, and timestamp mapping.

## Layer 7: Collaboration, Sync, And Sharing

### 7.1 Local-first resilience

- [ ] Move from browser-local-only assumptions to a desktop-grade storage strategy with crash-safe writes.
- [ ] Add notebook file integrity checks and repair flows.
- [ ] Add backup and restore support.

### 7.2 Sync model

- [ ] Define notebook sync architecture before implementing any cloud UI.
- [ ] Support offline edits, queued sync, conflict detection, and conflict resolution.
- [ ] Surface sync state at notebook, section, and page levels.

### 7.3 Sharing

- [ ] Support share links or exported packages only if backed by a real permission model.
- [ ] Add author presence and change attribution if real collaboration is introduced.

## Layer 8: Desktop Integration Parity

### 8.1 Window and shell

- [ ] Tighten window chrome, title behavior, menus, accelerators, and system integration.
- [ ] Add proper minimize, maximize, restore, and close behavior in desktop shells.
- [ ] Support native file dialogs, default app associations, and open-with handling.

### 8.2 Notifications and reminders

- [ ] Add reminder notifications for tasks and follow-ups.
- [ ] Support deep links back into the relevant note or paragraph.

### 8.3 Accessibility

- [ ] Full keyboard traversal across ribbon, panes, dialogs, search, and editor.
- [ ] Screen reader labels for all ribbon commands and canvas objects.
- [ ] High contrast and reduced motion support.

## Layer 9: Visual Fidelity Fixes

- [ ] Audit spacing, border weight, type scale, icon sizing, and control density against current OneNote desktop.
- [ ] Match inactive, hover, pressed, and selected states more precisely.
- [ ] Tighten section tab dimensions and page list rhythm.
- [ ] Improve pane separators, title row spacing, and command cluster proportions.
- [ ] Ensure the app still looks like OneNote under window resizing, high DPI, and different font scaling.

## Layer 10: Replace Fake Features

These are currently the biggest parity breaks because the UI implies deeper behavior than the app provides.

- [ ] Remove or fully implement `Find Outlook Tasks`.
- [ ] Remove or fully implement `Copilot` actions and prompt execution.
- [ ] Split `Dictate` from `Audio` clearly and make `Dictate` actual speech-to-text.
- [ ] Replace prompt-driven `Tag` flows with structured dialogs or panes.
- [ ] Replace template-insertion stand-ins where the label implies data-aware workflows.

## Verification Matrix

No feature is complete until it passes these checks.

### Behavior checks

- [ ] Pointer interaction works
- [ ] Keyboard interaction works
- [ ] State persists across reload
- [ ] State persists across app restart
- [ ] State survives notebook export/import where applicable
- [ ] Error handling is user-visible and recoverable

### Regression checks

- [ ] Unit coverage for pure model logic
- [ ] Integration coverage for notebook operations
- [ ] UI automation coverage for ribbon commands and major flows
- [ ] Smoke coverage for create/edit/move/delete/search/save/reopen

### Parity checks

- [ ] Command labels match behavior
- [ ] Shortcuts match expected platform behavior
- [ ] Results are not merely visually similar
- [ ] No placeholder UI remains in user-facing advanced surfaces

## Implementation Order

This is the order required to reach genuine OneNote-level depth without accumulating fragile hacks.

1. Replace the page storage/editor foundation with a structured model and real undo/redo.
2. Finish hierarchy, drag/drop, and selection parity.
3. Replace placeholder Home ribbon commands with real implementations.
4. Expand search, tags, and task aggregation.
5. Upgrade draw, audio, dictation, and transcription.
6. Improve history, review, and view surfaces.
7. Add desktop resilience, backup, and sync architecture.
8. Finalize visual fidelity and full accessibility verification.

## Definition Of Done

A parity item is done only when:

- the feature behaves like OneNote in normal use
- the feature survives persistence and reload
- the feature has no placeholder label/behavior mismatch
- the feature is covered by automated verification
- the feature does not regress adjacent notebook workflows
