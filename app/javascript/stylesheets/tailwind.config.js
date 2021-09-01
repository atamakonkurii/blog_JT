module.exports = {
  purge: [
    './app/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/javascripts/**/*.js'
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      colors: {
        'nittai_black': '#222831',
        'nittai_grey': '#393E46',
        'nittai_teal': '#00ADB5',
        'nittai_whitegrey': '#EEEEEE',
      }
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
