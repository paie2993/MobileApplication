package com.example.mynativehomework.update

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.MenuItem
import androidx.core.app.NavUtils
import androidx.recyclerview.widget.RecyclerView
import com.example.mynativehomework.ItemListActivity
import com.example.mynativehomework.R
import com.example.mynativehomework.data.Repository
import com.example.mynativehomework.form.FormOperator
import com.example.mynativehomework.form.FormRecyclerViewAdapter
import com.example.mynativehomework.model.DuePayment
import kotlinx.android.synthetic.main.activity_create_activity.fab
import kotlinx.android.synthetic.main.activity_item_update.*

class UpdateActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_item_update)

        setDisplayHomeAsUp()

        val formOperator = getFormOperator()
        setupRecyclerView(update_form, formOperator)

        fab.setOnClickListener { view ->
            if (formOperator.modifyRepository(view, Repository::updateDuePayment)) {
                runHomeOptionBehaviour()
            }
        }
    }

    // return to the home-page
    private fun setDisplayHomeAsUp() = supportActionBar?.setDisplayHomeAsUpEnabled(true)

    override fun onOptionsItemSelected(item: MenuItem) =
        when (item.itemId) {
            android.R.id.home -> runHomeOptionBehaviour()
            else -> defaultOptionsItemSelected(item)
        }

    private fun runHomeOptionBehaviour(): Boolean {
        NavUtils.navigateUpTo(this, buildNavigateHomeIntent())
        return true
    }

    private fun buildNavigateHomeIntent(): Intent =
        Intent(this, ItemListActivity::class.java)
            .apply { flags = Intent.FLAG_ACTIVITY_CLEAR_TOP }

    private fun defaultOptionsItemSelected(item: MenuItem): Boolean =
        super.onOptionsItemSelected(item)


    //     configure recycler view
    private fun setupRecyclerView(recyclerView: RecyclerView, formOperator: FormOperator) {
        recyclerView.adapter = FormRecyclerViewAdapter(formOperator.fields)
    }

    // update specifics
    private fun getFormOperator(): FormOperator {
        val itemId = getItemId()
        val duePayment = getDuePayment(itemId)
        return FormOperator.create(duePayment)
    }

    private fun getItemId(): Int = intent.getStringExtra("item_id")!!.toInt()

    private fun getDuePayment(id: Int): DuePayment? = Repository.find(id)
}