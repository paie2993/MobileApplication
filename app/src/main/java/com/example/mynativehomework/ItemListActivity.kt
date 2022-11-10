package com.example.mynativehomework

import android.content.Intent
import android.graphics.Color
import android.os.Bundle
import android.util.Log
import android.view.View
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.ItemTouchHelper
import androidx.recyclerview.widget.RecyclerView
import com.example.mynativehomework.adapter.RecyclerViewAdapter
import com.example.mynativehomework.create.CreateActivity
import com.example.mynativehomework.data.Repository
import com.example.mynativehomework.delete.SwipeToDelete
import com.example.mynativehomework.model.DuePayment
import com.google.android.material.snackbar.Snackbar
import kotlinx.android.synthetic.main.activity_due_payment_list.*
import kotlinx.android.synthetic.main.recycler_view_list.*


class ItemListActivity : AppCompatActivity() {

    private val onCreateClickListener: View.OnClickListener =
        View.OnClickListener(::setOnCreateClick)

    private val adapter = RecyclerViewAdapter()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_due_payment_list)

        Log.i("information", "onCreate called")

        setSupportActionBar(toolbar)

        toolbar.title = title
        fab.setOnClickListener(onCreateClickListener)

        setupRecyclerView(recycler_view_list)
        enableSwipeToDeleteAndUndo(layout_view, recycler_view_list)
    }

    private fun setupRecyclerView(recyclerView: RecyclerView) {
        Repository.populateRepository(this)
        recyclerView.adapter = adapter
        Repository.subscriber = adapter
    }

    private fun setOnCreateClick(view: View) {
        val intent = buildCreateIntent(view)
        view.context.startActivity(intent)
    }

    private fun buildCreateIntent(view: View): Intent =
        Intent(view.context, CreateActivity::class.java)


    private fun enableSwipeToDeleteAndUndo(layoutView: View, recyclerView: RecyclerView) {

        val swipeToDelete = object : SwipeToDelete(this) {

            override fun onSwiped(viewHolder: RecyclerView.ViewHolder, i: Int) {

                val position = viewHolder.adapterPosition
                val item = Repository.data[position]
                Repository.remove(position)

                undoSnackbar(layoutView, item, position)
            }
        }
        val itemTouchHelper = ItemTouchHelper(swipeToDelete)
        itemTouchHelper.attachToRecyclerView(recyclerView)
    }

    private fun undoSnackbar(layoutView: View, item: DuePayment, position: Int) =
        Snackbar.make(
            layoutView,
            "Item was removed from the list.",
            Snackbar.LENGTH_LONG
        ).setAction("Undo") { Repository.addAtIndex(item, position) }
            .setActionTextColor(Color.GREEN)
            .show()
}