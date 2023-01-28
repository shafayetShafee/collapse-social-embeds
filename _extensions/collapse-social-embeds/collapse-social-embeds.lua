-- based on the source code from https://github.com/sellorm/quarto-social-embeds

local function ensureHtmlDeps()
  quarto.doc.add_html_dependency({
  name = "collapse-social-embeds",
  version = "1.0.0",
  stylesheets = {"resources/css/collapse.css"}
})
end

local str = pandoc.utils.stringify
local p = quarto.log.output

function embed_gist()
  return {
    Div = function(el)
      if el.classes:includes('gist') 
      then
        local attr = el.attributes
        local user = attr.user
        local gist_id = attr.gist_id
        local collapse_appearance = "default"
        --p(user)
        --p(gist_id)
        if attr['appearance'] then
          collapse_appearance = attr['appearance']
        end
        local file_fragment = ""
        if attr['file-fragment'] ~= nil then
          local file = attr['file-fragment']
          file_fragment = '?file=' .. file
        end
        local icon = attr['icon'] or true
        -- Assemble HTML to be returned
        local html = '<script src="https://gist.github.com/'
            .. user
            .. '/'
            .. gist_id
            .. '.js'
            .. file_fragment
            .. '"></script>'

        local gist_content = pandoc.RawInline('html', html)
        local caption = "Github gist by" .. user
        --return gist_content
        return pandoc.Div({quarto.Callout({
          type = "note",
          icon = icon,
          collapse = true,
          caption = caption,
          content =  { gist_content },
          appearance = collapse_appearance
        })}, {class = 'gist'})
      end
    end
  }
end


function Pandoc(doc)
  --if quarto.doc.isFormat('html') then
    ensureHtmlDeps()
    local doc = doc:walk(embed_gist())
    return doc
  --end
end