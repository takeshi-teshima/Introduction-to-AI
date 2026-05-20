-- Pandoc Lua filter to convert custom Markdown fenced divs AND headers into LaTeX tcolorbox environments.

-- Helper function to check if an element has a given class (compatible with all versions)
local function has_class(el, target_class)
  if not el or not el.classes then return false end
  for _, c in ipairs(el.classes) do
    if c == target_class then
      return true
    end
  end
  return false
end

-- 1. Helper function to transform Divs with custom classes into target environments
function transform_div(el)
  -- Handles questionbox
  if has_class(el, 'questionbox') then
    local label = el.attributes['label'] or el.identifier
    local title = el.attributes['title'] or ""
    local difficulty = el.attributes['difficulty']

    if FORMAT:match 'latex' then
      if difficulty then
        title = title .. " \\hfill \\normalfont \\small 難易度：" .. difficulty
      end
      local opt = ""
      if label and label ~= "" then
        opt = "[label=" .. label .. "]"
      end
      local before = pandoc.RawBlock('latex', '\\begin{questionbox}' .. opt .. '{' .. title .. '}')
      local after = pandoc.RawBlock('latex', '\\end{questionbox}')
      table.insert(el.content, 1, before)
      table.insert(el.content, after)
      return el.content
    else
      -- Fallback for HTML or other formats: wrap in a nice div with title
      local items = {}
      if title ~= "" or difficulty then
        local title_text = title
        if difficulty then
          title_text = title .. " (難易度：" .. difficulty .. ")"
        end
        local header = pandoc.Para({pandoc.Strong(title_text)})
        table.insert(items, header)
      end
      for _, block in ipairs(el.content) do
        table.insert(items, block)
      end
      el.content = items
      return el
    end
  end

  -- Handles answerbox
  if has_class(el, 'answerbox') then
    local label = el.attributes['label'] or el.identifier
    local ref = el.attributes['ref'] or ""

    if FORMAT:match 'latex' then
      local opt = ""
      if label and label ~= "" then
        opt = "[phantomlabel=" .. label .. "]"
      end
      local before = pandoc.RawBlock('latex', '\\begin{answerbox}' .. opt .. '{' .. ref .. '}')
      local after = pandoc.RawBlock('latex', '\\end{answerbox}')
      table.insert(el.content, 1, before)
      table.insert(el.content, after)
      return el.content
    else
      -- Fallback for HTML or other formats
      local items = {}
      local header = pandoc.Para({pandoc.Strong("解答・解説")})
      table.insert(items, header)
      for _, block in ipairs(el.content) do
        table.insert(items, block)
      end
      el.content = items
      return el
    end
  end

  -- Handles generic tcolorbox
  if has_class(el, 'tcolorbox') then
    local title = el.attributes['title']
    local option = el.attributes['option']

    if FORMAT:match 'latex' then
      local opt_parts = {}
      if option then
        table.insert(opt_parts, option)
      end
      if title then
        table.insert(opt_parts, "title={" .. title .. "}")
      end
      local opt = ""
      if #opt_parts > 0 then
        opt = "[" .. table.concat(opt_parts, ", ") .. "]"
      end
      local before = pandoc.RawBlock('latex', '\\begin{tcolorbox}' .. opt)
      local after = pandoc.RawBlock('latex', '\\end{tcolorbox}')
      table.insert(el.content, 1, before)
      table.insert(el.content, after)
      return el.content
    else
      -- Fallback for HTML
      local items = {}
      if title then
        local header = pandoc.Para({pandoc.Strong(title)})
        table.insert(items, header)
      end
      for _, block in ipairs(el.content) do
        table.insert(items, block)
      end
      el.content = items
      return el
    end
  end

  -- Handles right alignment class
  if has_class(el, 'right') then
    if FORMAT:match 'latex' then
      local before = pandoc.RawBlock('latex', '\\hfill ')
      table.insert(el.content, 1, before)
      return el.content
    else
      el.attributes['style'] = 'text-align: right;'
      return el
    end
  end
end

-- 2. Hook to process Div elements directly (handles Fenced Divs)
function Div(el)
  return transform_div(el)
end

-- 3. Document-wide filter to find headers with custom classes and group subsequent blocks into Divs
function Pandoc(doc)
  local new_blocks = {}
  local i = 1
  local blocks = doc.blocks
  while i <= #blocks do
    local block = blocks[i]
    if block.t == 'Header' and (has_class(block, 'questionbox') or has_class(block, 'answerbox') or has_class(block, 'tcolorbox')) then
      local header = block
      local level = header.level
      
      -- Determine the target class name
      local class_name = ""
      if has_class(header, 'questionbox') then
        class_name = 'questionbox'
      elseif has_class(header, 'answerbox') then
        class_name = 'answerbox'
      elseif has_class(header, 'tcolorbox') then
        class_name = 'tcolorbox'
      end
      
      -- Extract attributes
      local label = header.identifier
      local title = pandoc.utils.stringify(header.content)
      local difficulty = header.attributes['difficulty']
      local ref = header.attributes['ref']
      local option = header.attributes['option']
      
      -- Collect all blocks until we hit a header of the same or higher level
      local inner_blocks = {}
      i = i + 1
      while i <= #blocks do
        local next_block = blocks[i]
        if next_block.t == 'Header' and next_block.level <= level then
          break
        else
          table.insert(inner_blocks, next_block)
          i = i + 1
        end
      end
      
      -- Create a Div container and set attributes directly
      local div = pandoc.Div(inner_blocks)
      div.identifier = label
      div.classes = {class_name}
      if label ~= "" then div.attributes['label'] = label end
      if title ~= "" then div.attributes['title'] = title end
      if difficulty then div.attributes['difficulty'] = difficulty end
      if ref then div.attributes['ref'] = ref end
      if option then div.attributes['option'] = option end
      
      -- Immediately transform this Div
      local transformed = transform_div(div)
      if transformed then
        if type(transformed) == 'table' then
          for _, tb in ipairs(transformed) do
            table.insert(new_blocks, tb)
          end
        else
          table.insert(new_blocks, transformed)
        end
      else
        table.insert(new_blocks, div)
      end
    else
      table.insert(new_blocks, block)
      i = i + 1
    end
  end
  doc.blocks = new_blocks
  return doc
end
