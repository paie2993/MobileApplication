package com.example.mynativehomework.delete

import android.content.Context
import android.graphics.*
import android.graphics.drawable.ColorDrawable
import android.graphics.drawable.Drawable
import androidx.core.content.ContextCompat
import androidx.recyclerview.widget.ItemTouchHelper
import androidx.recyclerview.widget.RecyclerView

// I took inspiration from a webpage, this is not entirely my work
abstract class SwipeToDelete(
    context: Context
) : ItemTouchHelper.Callback() {

    private val paintForClearingCanvas: Paint =
        Paint().apply { xfermode = PorterDuffXfermode(PorterDuff.Mode.CLEAR) }
    private val background: ColorDrawable =
        ColorDrawable().apply { color = Color.parseColor("#b80f0a") }

    private val deleteDrawable: Drawable? =
        ContextCompat.getDrawable(context, android.R.drawable.ic_delete)
    private val intrinsicWidth: Int = deleteDrawable!!.intrinsicWidth
    private val intrinsicHeight: Int = deleteDrawable!!.intrinsicHeight

    override fun getMovementFlags(
        recyclerView: RecyclerView,
        viewHolder: RecyclerView.ViewHolder
    ): Int =
        makeMovementFlags(0, ItemTouchHelper.LEFT) // swipe to the left

    override fun onMove(
        recyclerView: RecyclerView,
        viewHolder: RecyclerView.ViewHolder,
        viewHolder1: RecyclerView.ViewHolder
    ): Boolean =
        false // this is for drag and drop, we don't need it

    override fun onChildDraw(
        canvas: Canvas,
        recyclerView: RecyclerView,
        viewHolder: RecyclerView.ViewHolder,
        dX: Float,
        dY: Float,
        actionState: Int,
        isCurrentlyActive: Boolean
    ) {
        super.onChildDraw(canvas, recyclerView, viewHolder, dX, dY, actionState, isCurrentlyActive)

        val view = viewHolder.itemView
        val itemHeight = view.height

        val isCancelled = determineIfCancelled(dX, isCurrentlyActive)
        if (isCancelled) {
            applyCancellation(
                canvas, recyclerView, viewHolder, dX, dY, actionState, isCurrentlyActive
            )
            return
        }

        background.apply {
            bounds = Rect(view.right + dX.toInt(), view.top, view.right, view.bottom)
        }.draw(canvas)

        val deleteIconTop = view.top + (itemHeight - intrinsicHeight) / 2
        val deleteIconMargin = (itemHeight - intrinsicHeight) / 2
        val deleteIconLeft = view.right - deleteIconMargin - intrinsicWidth
        val deleteIconRight = view.right - deleteIconMargin
        val deleteIconBottom = deleteIconTop + intrinsicHeight

        deleteDrawable!!.setBounds(deleteIconLeft, deleteIconTop, deleteIconRight, deleteIconBottom)
        deleteDrawable.draw(canvas)
        super.onChildDraw(canvas, recyclerView, viewHolder, dX, dY, actionState, isCurrentlyActive)
    }

    private fun determineIfCancelled(dX: Float, isCurrentlyActive: Boolean): Boolean =
        (dX == 0f) && !isCurrentlyActive

    private fun applyCancellation(
        canvas: Canvas,
        recyclerView: RecyclerView,
        viewHolder: RecyclerView.ViewHolder,
        dX: Float,
        dY: Float,
        actionState: Int,
        isCurrentlyActive: Boolean
    ) {
        val itemView = viewHolder.itemView

        clearCanvas(
            canvas,
            itemView.right + dX,
            itemView.top.toFloat(),
            itemView.right.toFloat(),
            itemView.bottom.toFloat()
        )

        super.onChildDraw(
            canvas, recyclerView, viewHolder, dX, dY, actionState, isCurrentlyActive
        )
    }

    private fun clearCanvas(c: Canvas, left: Float, top: Float, right: Float, bottom: Float) {
        c.drawRect(left, top, right, bottom, paintForClearingCanvas)
    }

    override fun getSwipeThreshold(viewHolder: RecyclerView.ViewHolder): Float = 0.7f
}