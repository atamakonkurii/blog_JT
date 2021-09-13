module.exports = {
  purge: [
    './app/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/javascript/**/*.vue',
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      colors: {
        'nittai_black': '#222831',
        'nittai_grey': '#393E46',
        'nittai_teal_thin' : '#8fecf3',
        'nittai_teal': '#00ADB5',
        'nittai_teal_strong' : '#014c4e',
        'nittai_whitegrey': '#EEEEEE',
      }
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
