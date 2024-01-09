-- the code for embedding social contents were taken
-- from https://github.com/sellorm/quarto-social-embeds

local str = pandoc.utils.stringify
local p = quarto.log.output


local function ensureHtmlDeps()
  quarto.doc.add_html_dependency({
      name = "collapse-social-embeds",
      version = "1.1.0",
      stylesheets = {"resources/css/collapse.css"}
    },
    {
      name = 'twitter',
      version = '0.0.1',
      scripts = {
          {
            path = "",
            attribs = {src="https://platform.twitter.com/widgets.js"},
            afterBody = true
          }
      }
    }
  )
end


function embed_gist()
  return {
    Div = function(el)
      if el.classes:includes('gist')
      then
        local attr = el.attributes
        local user = attr.user
        local gist_id = attr.gist_id
        local file_fragment = ""
        if attr['file-fragment'] ~= nil then
          local file = attr['file-fragment']
          file_fragment = '?file=' .. file
        end

        -- Assemble HTML to be returned
        local html = '<script src="https://gist.github.com/'
            .. user
            .. '/'
            .. gist_id
            .. '.js'
            .. file_fragment
            .. '"></script>'
        local gist_content = pandoc.RawInline('html', html)
        local icon = attr['icon'] or true
        local collapse_appearance = attr['appearance'] or "default"
        local collapse = attr['collapse'] or true
        local title = attr['title'] or "Github gist by " .. user
        return pandoc.Div({quarto.Callout({
          type = "note",
          icon = icon,
          collapse = collapse,
          title = title,
          content =  { gist_content },
          appearance = collapse_appearance
        })}, {class = 'gist'})
      end
    end
  }
end


function embed_loom()
  return {
    Div = function(el)
      if el.classes:includes('loom')
      then
        local attr = el.attributes
        local video_id = attr['video_id']
        -- Assemble HTML to be returned
        local html = '<div style="position: relative; padding-bottom: 56.25%; height: 0;"><iframe src="https://www.loom.com/embed/'
            .. video_id
            .. '" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;"></iframe></div>'

	      local video = pandoc.RawInline('html', html)
	      local icon = attr['icon'] or true
        local collapse_appearance = attr['appearance'] or "default"
        local collapse = attr['collapse'] or true
        local title = attr['title'] or "Loom Video"
        return pandoc.Div({quarto.Callout({
          type = "note",
          icon = icon,
          collapse = collapse,
          title = title,
          content =  { video },
          appearance = collapse_appearance
        })}, {class = 'loom'})
      end
    end
  }
end


function embed_mastodon()
  return {
    Div = function(el)
      if el.classes:includes('mastodon')
      then
        local attr = el.attributes
        local mstd_url = str(attr['url'])
        -- Assemble HTML to be returned
        local html = '<div style="position: relative; padding-bottom: 56.25%; height: 0;"> <iframe src="'.. mstd_url ..'/embed" class="mastodon-embed" style="max-width: 100%; border: 0;" width="100%" height="400" allowfullscreen="allowfullscreen"></iframe><script src="https://mastodon.social/embed.js" async="async"></script></div>'
	      local mstd = pandoc.RawInline('html', html)
	      local icon = attr['icon'] or true
        local collapse_appearance = attr['appearance'] or "default"
        local collapse = attr['collapse'] or true
        local title = attr['title'] or "Mastodon Post"
        return pandoc.Div({quarto.Callout({
          type = "note",
          icon = icon,
          collapse = collapse,
          title = title,
          content =  { mstd },
          appearance = collapse_appearance
        })}, {class = 'mstd'})
      end
    end
  }
end


function embed_tweet()
  return {
     Div = function(el)
       if el.classes:includes('twitter')
       then
         local attr = el.attributes
         local user = attr.user
         local status_id = attr.status_id
         -- Assemble the twitter oembed API URL from the user inputs
         local tweet_embed = 'https://publish.twitter.com/oembed?url=https://twitter.com/'
                .. user
                .. '/status/'
                .. status_id
                .. '&align=center'
         local mt, api_resp = pandoc.mediabag.fetch(tweet_embed)

         -- generate a random number to append to the html div ID to avoid re-use
         local id = math.random(10000, 99999)

         local tweet_data = '<div id="tweet-'
            .. id
            .. '"></div><script>tweet='
            .. api_resp
            .. ';document.getElementById("tweet-'
            .. id
            .. '").innerHTML = tweet["html"];</script>'

         local tweet = pandoc.RawInline('html', tweet_data)
         local icon = attr['icon'] or true
         local collapse_appearance = attr['appearance'] or "default"
         local collapse = attr['collapse'] or true
         local title = attr['title'] or "Tweet from " .. user
         return pandoc.Div({quarto.Callout({
          type = "note",
          icon = icon,
          collapse = collapse,
          title = title,
          content =  { tweet },
          appearance = collapse_appearance
          })}, {class = 'tweet'})
      end
    end
  }
end


function embed_vimeo()
  return {
    Div = function(el)
      if el.classes:includes('vimeo')
      then
        local attr = el.attributes
        local video_id = attr.video_id
        -- Assemble HTML to be returned
        local html = '<div style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden;"> <iframe src="https://player.vimeo.com/video/'
          .. video_id
          .. '" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; border:0;" title="vimeo video" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe> </div> '

	      local vimeo_video = pandoc.RawInline('html', html)
        local icon = attr['icon'] or true
        local collapse_appearance = attr['appearance'] or "default"
        local collapse = attr['collapse'] or true
        local title = attr['title'] or "Vimeo Video"
        return pandoc.Div({quarto.Callout({
          type = "note",
          icon = icon,
          collapse = collapse,
          title = title,
          content =  { vimeo_video },
          appearance = collapse_appearance
        })}, {class = 'vimeo'})
      end
    end
  }
end


function embed_yt()
  return {
    Div = function(el)
      if el.classes:includes('youtube')
      then
        local attr = el.attributes
        local video_id = attr.video_id
        -- Assemble HTML to be returned
        local html = '<div id="youtube-frame" style="position: relative; padding-bottom: 56.25%; /* 16:9 */ height: 0;"><iframe width="100%" height="" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;" src="https://www.youtube.com/embed/'
          .. video_id
          .. '" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></div>'
	      local yt_video = pandoc.RawInline('html', html)
	      local icon = attr['icon'] or true
        local collapse_appearance = attr['appearance'] or "default"
        local collapse = attr['collapse'] or true
        local title = attr['title'] or "Youtube Video"
        return pandoc.Div({quarto.Callout({
          type = "note",
          icon = icon,
          collapse = collapse,
          title = title,
          content =  { yt_video },
          appearance = collapse_appearance
        })}, {class = 'youtube'})
      end
    end
  }
end


function Pandoc(doc)
  if quarto.doc.isFormat('html') then
    ensureHtmlDeps()
    local doc = doc:walk(embed_gist())
    doc = doc:walk(embed_loom())
    doc = doc:walk(embed_mastodon())
    doc = doc:walk(embed_tweet())
    doc = doc:walk(embed_vimeo())
    return doc:walk(embed_yt())
  end
end
