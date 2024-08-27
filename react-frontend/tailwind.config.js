/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {},
    colors: {
      'primaryColor': "#1E79E1",
      'secondaryColor': "#bcbcbc",
      // 'customBlack': "#000000",
      'subtitleColor':"#4f4b68",
      'white': "#FFFFFF"
    }
  },
  plugins: [],
};