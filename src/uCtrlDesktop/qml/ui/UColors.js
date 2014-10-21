.pragma library

var colors = {
    // µCtrl's Green variation
   "uLightGreen": "#DAF2DA",
   "uMediumLightGreen": "#0DBE0D",
   "uGreen": "#0D9B0D",
   "uDarkGreen": "#0D740D",


   // µCtrl's Red variation
   "uLightRed": "#FFBFBF",
   "uRed": "#D90E0E",
   "uDarkRed": "#A60E0E",

   // White colors
   "uWhite": "white",

   // Black colors
   "uBlack": "black",

   // Grey colors
   "uUltraLightGrey": "#F7F6F6",
   "uLightGrey": "#EDEDED",
   "uMediumLightGrey": "#D4D4D4",
   "uGrey": "#AAAAAA",
   "uMediumDarkGrey": "#737373",
   "uDarkGreyHover": "#5A5A5A",
   "uDarkGrey": "#3C3C3C",
   "uDarkerGrey": "#383838",
   "uDarkestGrey": "#222222",

   // Transparent color
   "uTransparent": "transparent"
}

function get(color) {
    return colors[color];
}
