return {

    cmd = {'typescript-language-server', '--stdio'},
    filetypes = {'typescript', 'vue'},
  init_options = {
    plugins = { -- I think this was my breakthrough that made it work
      {
        name = "@vue/typescript-plugin",
        location = "/usr/lib/node_modules/@vue/language-server",
        languages = { "vue" },
      },
    },
  },


}
