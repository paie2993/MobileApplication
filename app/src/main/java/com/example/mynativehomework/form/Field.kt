package com.example.mynativehomework.form

data class Field(
    val label: String,
    var value: String,
    val validationRegex: String,
    val optional: Boolean
)
