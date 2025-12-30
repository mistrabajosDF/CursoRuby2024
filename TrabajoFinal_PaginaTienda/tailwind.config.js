/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js'
  ],

  plugins: [
    function({ addBase }) {
      console.log('Tailwind está compilando...');
    }
  ],



  theme: {
    extend: {},
  }
}