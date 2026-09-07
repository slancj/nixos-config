[
  {
    name = "Bookmarks Toolbar";
    toolbar = true;
    bookmarks = [
      {
        name = "AI";
        url = "https://www.google.com/ai?q=%s";
        keyword = "@gai";
      }
      {
        name = "Wiki";
        url = "https://en.wikipedia.org";
        keyword = "w";
      }
      {
        name = "GitHub";
        url = "https://github.com";
        keyword = "gh";
      }
      {
        name = "AI Tools";
        bookmarks = [
          {
            name = "AI Studio";
            url = "https://aistudio.google.com/prompts/new_chat";
            keyword = "ai";
          }
          {
            name = "AI Studio (Account 2)";
            url = "https://aistudio.google.com/u/1/prompts/new_chat";
            keyword = "ai1";
          }
          {
            name = "AI Studio (Account 3)";
            url = "https://aistudio.google.com/u/2/prompts/new_chat";
            keyword = "ai2";
          }
          {
            name = "AI Studio (Account 4)";
            url = "https://aistudio.google.com/u/3/prompts/new_chat";
            keyword = "ai3";
          }
          {
            name = "Claude";
            url = "https://claude.ai";
            keyword = "cl";
          }
          {
            name = "NotebookLM";
            url = "https://notebooklm.google.com";
            keyword = "nlm";
          }
        ];
      }
      {
        name = "Reading";
        bookmarks = [
          {
            name = "HackerNews";
            url = "https://hn.algolia.com/?dateRange=pastWeek&sort=byPopularity&type=story";
            keyword = "hn";
          }
          {
            name = "Lobsters";
            url = "https://lobste.rs";
            keyword = "lb";
          }
          {
            name = "Astral Codex Ten";
            url = "https://astralcodexten.com";
            keyword = "act";
          }
          {
            name = "LessWrong";
            url = "https://www.lesswrong.com";
            keyword = "lw";
          }
          {
            name = "Youtube";
            url = "https://youtube.com";
            keyword = "yt";
          }
        ];
      }
      {
        name = "NixOS";
        bookmarks = [
          {
            name = "Packages";
            url = "https://search.nixos.org/packages?query=%s";
            keyword = "np";
          }
          {
            name = "Options";
            url = "https://search.nixos.org/options?query=%s";
            keyword = "no";
          }
          {
            name = "Home Manager";
            url = "https://home-manager-options.extranix.com/?query=%s";
            keyword = "hm";
          }
        ];
      }
      {
        name = "Search";
        bookmarks = [
          {
            name = "DuckDuckGo";
            url = "https://duckduckgo.com/?q=%s";
            keyword = "d";
          }
          {
            name = "Google";
            url = "https://www.google.com/search?q=%s";
            keyword = "g";
          }
          {
            name = "Kagi";
            url = "https://kagi.com/search?q=%s";
            keyword = "k";
          }
          {
            name = "Startpage";
            url = "https://www.startpage.com/search?q=%s";
            keyword = "sp";
          }
          {
            name = "Perplexity";
            url = "https://www.perplexity.ai/search?q=%s";
            keyword = "pp";
          }
          {
            name = "YouTube";
            url = "https://www.youtube.com/results?search_query=%s";
            keyword = "yt";
          }
          {
            name = "Wikipedia";
            url = "https://en.wikipedia.org/wiki/Special:Search?search=%s";
            keyword = "wk";
          }
        ];
      }
      {
        name = "Academic";
        bookmarks = [
          {
            name = "WCC";
            url = "https://experience.elluciancloud.com/wcc/";
            keyword = "wcc";
          }
          {
            name = "Canvas - PCC";
            url = "https://pccsk12.instructure.com/login/saml";
            keyword = "canvas";
          }
        ];
      }
      {
        name = "Browser";
        bookmarks = [
          {
            name = "Settings";
            url = "about:preferences";
            keyword = "s";
          }
          {
            name = "Config";
            url = "about:config";
            keyword = "c";
          }
          {
            name = "Profile";
            url = "about:profiles";
            keyword = "p";
          }
          {
            name = "Design Mode";
            url = "javascript:(function(){if(document.designMode==='on'){document.designMode='off';document.body.contentEditable='false';}else{document.designMode='on';document.body.contentEditable='true';}})();";
            keyword = "dm";
          }
          {
            name = "Video";
            url = "javascript:(function(){var v=document.querySelector('video');if(v){var s=prompt('Enter playback speed:',v.playbackRate);if(s){v.playbackRate=parseFloat(s);}}else{alert('No video found on this page.');}})();";
            keyword = "vp";
          }
        ];
      }
    ];
  }
]
