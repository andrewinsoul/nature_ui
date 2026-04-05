const esbuild = require("esbuild");

const watch = process.argv.includes("--watch");

esbuild.build({
    entryPoints: ["assets/js/index.js"],
    bundle: true,
    minify: !watch,
    sourcemap: watch,
    target: ["es2017"],
    outfile: "priv/static/nature_ui/hooks.js",
    watch: watch && {
        onRebuild(error) {
            if (error) console.error("❌ Rebuild failed:", error);
            else console.log("✅ Rebuilt successfully");
        }
    }
}).catch(() => process.exit(1));
