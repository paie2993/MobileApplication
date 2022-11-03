package com.example.mynativehomework.adapter

import android.content.Context
import android.content.Intent
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.example.mynativehomework.details.ItemDetailsActivity
import com.example.mynativehomework.R
import com.example.mynativehomework.data.Repository
import com.example.mynativehomework.model.DuePayment
import kotlinx.android.synthetic.main.list_item.view.*

class RecyclerViewAdapter(
    context: Context
) : RecyclerView.Adapter<RecyclerViewAdapter.ViewHolder>() {

    init {
        Repository.populateRepository(context)
    }

    private val values: List<DuePayment>
        get() = Repository.data

    private val onClickListener: View.OnClickListener =
        View.OnClickListener { view ->
            val intent = buildClickItemIntent(context = view.context, item = view.tag as DuePayment)
            view.context.startActivity(intent)
        }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val view = LayoutInflater.from(parent.context)
            .inflate(R.layout.list_item, parent, false)
        return ViewHolder(view)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val item = values[position]
        Log.d("Bind View Holder", "onBindViewHolder: position = $position, item = ${item.totalSum}")
        holder.contentView.text = item.toString()
        with(holder.itemView) {
            tag = item
            setOnClickListener(onClickListener)
        }
    }

    override fun getItemCount() = values.size

    private fun buildClickItemIntent(context: Context, item: DuePayment): Intent =
        Intent(context, ItemDetailsActivity::class.java)
            .apply { putExtra("item_id", item.id.toString()) }

    inner class ViewHolder(view: View) : RecyclerView.ViewHolder(view) {
        val idView: TextView = view.id_text
        val contentView: TextView = view.content
    }
}