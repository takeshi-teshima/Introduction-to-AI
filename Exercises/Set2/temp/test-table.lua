function Table(el)
  local latex = "\\begin{center}\n\\begin{tabular}{"
  local aligns = {}
  for _, colspec in ipairs(el.colspecs) do
    local align = colspec[1]
    if align == 'AlignLeft' then table.insert(aligns, "l")
    elseif align == 'AlignRight' then table.insert(aligns, "r")
    elseif align == 'AlignCenter' then table.insert(aligns, "c")
    else table.insert(aligns, "c") end
  end
  latex = latex .. table.concat(aligns, "") .. "}\n"
  
  local function row_to_latex(row)
    local cells = {}
    for _, cell in ipairs(row.cells) do
      table.insert(cells, pandoc.utils.stringify(cell))
    end
    return table.concat(cells, " & ") .. " \\\\"
  end
  
  if el.head and #el.head.rows > 0 then
    for _, row in ipairs(el.head.rows) do
      latex = latex .. row_to_latex(row) .. " \\hline\n"
    end
  end
  
  for _, body in ipairs(el.bodies) do
    for _, row in ipairs(body.body) do
      latex = latex .. row_to_latex(row) .. "\n"
    end
  end
  latex = latex .. "\\end{tabular}\n\\end{center}"
  return pandoc.RawBlock('latex', latex)
end
