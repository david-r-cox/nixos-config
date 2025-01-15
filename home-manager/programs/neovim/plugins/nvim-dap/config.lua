-- https://stackoverflow.com/questions/78455585/correct-setup-for-debugging-nextjs-app-inside-neovim-with-dap
-- Server side:
require('dap').adapters['pwa-node'] = {
  type = 'server',
  host = 'localhost',
  port = '${port}',
  executable = {
  command = 'node',
    -- TODO: use home.file to place this and update the path
    args = {os.getenv('HOME') .. '/Downloads/js-debug-dap-v1.77.0/js-debug/src/dapDebugServer.js', '${port}' },
  },
}
local dap = require 'dap'
local js_based_languages = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' }
for _, language in ipairs(js_based_languages) do
  dap.configurations[language] = {
  -- ...
    {
      name = 'Next.js: debug server-side',
      type = 'pwa-node',
      request = 'attach',
      port = 9231,
      skipFiles = { '<node_internals>/**', 'node_modules/**' },
      cwd = '${workspaceFolder}/apps/web', -- TODO: don't hard-code this.
      sourceMaps = true,
      resolveSourceMapLocations = {
        '${workspaceFolder}/**',
        '!**/node_modules/**'
      },
      outFiles = {'${workspaceFolder}/apps/web/.next/**/*.js'},
    },
  }
  -- ...
end
-- Note: Ignore the following and use chrome (blah) for client-side debugging...
-- As bad as it sounds, the alternative still requires running two nvim instances
-- each with their own dap session.
--
-- Server side code can also be debugged in chrome:
-- https://github.com/vercel/next.js/discussions/66699
--
-- VSCode (blah) also supports full-stack debugging:
-- https://github.com/vercel/next.js/issues/62008#issuecomment-2571695815
--
---- TODO: add a toggle for client vs server debugging
---- Currently client is overwriting the server config and toggling is implemented
---- by commenting out the code below.
---- Client side:
--require('dap').adapters['chrome'] = {
--  type = 'executable',
--  command = vim.fn.exepath('node'),
--  args = {
--    -- TODO: either source from nixpkgs or use home.file to place this and update the path
--    os.getenv('HOME') .. '/src/github.com/vscode-chrome-debug/out/src/chromeDebug.js',
--  },
--  options = {
--    env = {
--      CHROME_EXECUTABLE = 'google-chrome-stable',
--    }
--  }
--}
--for _, language in ipairs(js_based_languages) do
--  dap.configurations[language] = {
--    -- ...
--    {
--      name = 'Next.js: debug client-side',
--      type = 'chrome',
--      request = 'attach',
--      url = 'http://localhost:3000',
--      port = 9222,
--      --webRoot = '${workspaceFolder}',
--      webRoot = '${workspaceFolder}/apps/web',
--      runtimeExecutable = vim.fn.exepath('google-chrome-stable'),
--      runtimeArgs = {'--remote-debugging-port=9222'},
--      sourceMaps = true, -- https://github.com/vercel/next.js/issues/56702#issuecomment-1913443304
--      sourceMapPathOverrides = {
--        -- Without Turbopack:
--        -- ['webpack://_N_E/*'] = '${webRoot}/*',
--        -- With Turbopack (see gh issue link above):
--        --['/turbopack/[project]/*'] = '${webRoot}/*',
--        ['webpack://_N_E/./apps/web/*'] = '${webRoot}/*',
--        ['webpack://./apps/web/*'] = '${webRoot}/*',
--        ['/turbopack/[project]/apps/web/*'] = '${webRoot}/*',
--        ['*'] = '${workspaceFolder}/*'
--      },
--    },
--    -- ...
--  }
--end
