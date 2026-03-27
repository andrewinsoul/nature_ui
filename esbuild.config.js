// esbuild.config.js
import esbuild from "esbuild";
import sveltePlugin from "esbuild-svelte";

esbuild.build({
    entryPoints: ["src/registry.js"],
    bundle: true,
    outfile: "priv/static/nature_ui/nature_ui.js",
    plugins: [sveltePlugin()],
    minify: true,
    sourcemap: true,
    format: "iife",
    globalName: "NatureUI"
}).catch(() => process.exit(1));
