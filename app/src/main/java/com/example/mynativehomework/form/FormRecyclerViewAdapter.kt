package com.example.mynativehomework.form

import android.text.Editable
import android.text.TextWatcher
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.EditText
import androidx.recyclerview.widget.RecyclerView
import com.example.mynativehomework.R
import kotlinx.android.synthetic.main.field.view.*

class FormRecyclerViewAdapter(
    fieldValues: List<Field>,
) : RecyclerView.Adapter<FormRecyclerViewAdapter.ViewHolder>() {

    private val fieldTextWatchers: List<FieldTextWatcher> = getEditables(fieldValues)

    private fun getEditables(fields: List<Field>): List<FieldTextWatcher> =
        fields.map { FieldTextWatcher(it) }


    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val view = LayoutInflater.from(parent.context).inflate(R.layout.field, parent, false)
        return ViewHolder(view)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val watcher: FieldTextWatcher = fieldTextWatchers[position]
        holder.editable.addTextChangedListener(watcher)
        holder.editable.setText(watcher.field.value)
        holder.editable.hint = watcher.field.label
        holder.itemView.tag = watcher
    }

    override fun getItemCount() = fieldTextWatchers.size

    inner class ViewHolder(view: View) : RecyclerView.ViewHolder(view) {
        val editable: EditText = view.value
    }

    private companion object {

        private class FieldTextWatcher(
            val field: Field
        ) : TextWatcher {

            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {
            }

            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
            }

            override fun afterTextChanged(s: Editable?) {
                field.value = s.toString()
            }
        }
    }
}