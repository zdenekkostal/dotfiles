return {
  'cormacrelf/dark-notify',
  config = function()
    require('dark_notify').run({
      schemes = {
        dark = 'rose-pine-main',
        light = 'rose-pine-dawn',
      },
    })
  end,
}
