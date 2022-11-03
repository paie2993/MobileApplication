package com.example.mynativehomework.details

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.example.mynativehomework.R
import com.example.mynativehomework.data.Repository
import com.example.mynativehomework.model.DuePayment
import kotlinx.android.synthetic.main.activity_item_details.*
import kotlinx.android.synthetic.main.activity_item_details.view.*
import kotlinx.android.synthetic.main.fragment_item_details.*

class ItemDetailFragment : Fragment() {

    private var item: DuePayment? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        arguments?.let {
            if (it.containsKey("item_id")) {
                item = Repository.data[it.getString("item_id")!!.toInt()]
                activity?.toolbar_layout?.title = item?.reason ?: "Reason undefined"
            }
        }
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        root: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        val rootView = inflater.inflate(item_detail, root, false)
        item?.let { rootView.item_detail.text = it.toString() }
        return rootView
    }
}
