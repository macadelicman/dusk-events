import { defineConfig } from "vite";
import ViteRails from "vite-plugin-rails";
import react from "@vitejs/plugin-react";

export default defineConfig({
  plugins: [
    ViteRails({
      envVars: { RAILS_ENV: "development" },
      envOptions: { defineOn: "import.meta.env" },
      fullReload: {
        additionalPaths: [],
      },
    }),
    react(),
  ],
});
