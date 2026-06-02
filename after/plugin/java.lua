-- jdtls requires Java 21+ to *run*, but the shell default (JAVA_HOME) is
-- Zulu 17, which makes jdtls quit with exit code 1 on launch.
-- Point only the jdtls launcher at a 21+ JDK; leave the shell default alone.
local jdtls_jdk = "/Library/Java/JavaVirtualMachines/jdk-25.jdk/Contents/Home"

if vim.fn.isdirectory(jdtls_jdk) == 1 then
    vim.lsp.config("jdtls", {
        cmd_env = { JAVA_HOME = jdtls_jdk },
    })
end
