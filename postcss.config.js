module.exports = {
  plugins: [
    require('tailwindcss')("./app/javascript/stylesheets/tailwind.config.js"),
    require('autoprefixer'),
    require('postcss-import'),
    require('postcss-flexbugs-fixes'),
    require('postcss-preset-env')({
      autoprefixer: {
        flexbox: 'no-2009'
      },
      stage: 3
    })
  ]
}

// 使っているクラスだけを抽出する設定
if (process.env.RAILS_ENV === "production") {
  environment.plugins.push(
      require('@fullhuman/postcss-purgecss')({
        content: [
          './app/**/*.html.erb',
          './app/**/*.js.erb',
          './app/helpers/**/*.rb',
        ],
        defaultExtractor: content => content.match(/[A-Za-z0-9-_:/]+/g) || []
      })
  )
}

module.exports = environment // エクスポート