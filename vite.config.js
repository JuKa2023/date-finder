import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

export default defineConfig({
	plugins: [vue()],
	resolve: {
		alias: {
			'@': '/src',
			'/img/': '/date-finder/img/',
		},
	},
	publicDir: 'public',
	base: '/date-finder/',
})
