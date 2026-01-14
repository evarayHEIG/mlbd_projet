// STYLE
#set text(lang: "fr")
#show: text.with(font: "New Computer Modern", size: 11pt)
#set par(justify: true)// Justify the text

// Display inline code in a small box with light gray backround that retains the correct baseline.
#show raw.where(block: false): box.with(
  fill: luma(240),
  inset: (x: 3pt, y: 0pt),
  outset: (y: 3pt),
  radius: 2pt,
)

// BODY
// Page de garde
#set page(header: none, margin: 2cm)

// logos mse et hes-so
#place(top + left, image("images/mse.png", width: 8cm))
#place(bottom + right, image("images/hes-so.png", width: 4cm))

#align(center)[

  #v(8cm)
  
  #text(size: 2.5em, weight: "bold")[
    Analogues climatiques en Europe
  ]
  
  #text(size: 1.3em)[
    Quelle ville vit aujourd'hui le climat passé ou futur de votre ville ?
  ]
  
  
  #v(2cm)
  
  #text(size: 1.1em)[
    Machine Learning on Big Data\
    MSE
  ]

  #v(1.5cm)
  
  #text(size: 1.1em)[Eva Ray, Massimo Stefani, Abdellah Jahjah Areddam]
  
  #text(size: 1em, lang: "fr")[
    #datetime.today().display("[day padding:none] Janvier [year]")
  ]

  
]

#pagebreak()

#set page(header: "MLBD", margin: 2cm, numbering: "1")
#counter(page).update(1)

#outline()

#pagebreak()

#set heading(numbering: "1.")

// Chapitres
#include "1_context.typ"
#include "2_database.typ"
#include "3_preprocessing.typ"
#include "4_machine_learning.typ"
#include "5_result.typ"
#include "6_analysis_conclusion.typ"
#pagebreak()

// Bibliographie
#show "Online": "En ligne"
#show "Available": "Lien"
#show link: l => underline(l)
#bibliography("biblio.bib", title: "Bibliographie", style: "ieee", full: true)