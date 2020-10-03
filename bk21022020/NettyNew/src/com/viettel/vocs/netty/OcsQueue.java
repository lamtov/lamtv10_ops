package com.viettel.vocs.netty;

/*
 * @OcsQueue.java	1.0  05/11/2011 
 * Copyright 2010 Viettel Telecom. All rights reserved.
 * VIETTEL PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 */
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.ReentrantLock;

/**
 * Description:
 *
 * @author: pmdv_hungtv7
 * @since: 05/11/2011
 */
public class OcsQueue<T> {

    public static final int SUCCESS = 0;
    public static final int MAX_LIMIT = -1;
    public static final int ERROR = -2;
    public static final int STOPPED = -3;
    private Queue<T> queue;
    private final ReentrantLock lock = new ReentrantLock();
    private int maxLimit;
    private final Condition available = lock.newCondition();
    private final Condition emptyCond = lock.newCondition();
    private boolean limit = false;
    private boolean empty = false;
    private boolean stop = false;
    private static long MAX_WAIT_DEQUEUE = 2000;
    private String name;

    public String getName() {
        return name;
    }

    public OcsQueue(int maxLimit, String name) {
        this.maxLimit = maxLimit;
        this.name = name;
        this.queue = new LinkedList();
    }

    public OcsQueue(int maxLimit) {
        this.queue = new LinkedList();
        this.maxLimit = maxLimit;
    }

    public int enqueue(T object) {
        lock.lock();
        try {
            if (stop) {
                return STOPPED;
            }
            if ((this.maxLimit > 0) && (this.queue.size() >= this.maxLimit)) {
                this.limit = true;
                return MAX_LIMIT;
            }
            this.queue.add(object);
            if (empty) {
                empty = false;
                this.emptyCond.signalAll();
            }
            return SUCCESS;
        } finally {
            lock.unlock();
        }

    }

    public int enqueueList(List<T> list) {
        lock.lock();
        try {
            if (stop) {
                return STOPPED;
            }
            if ((this.maxLimit > 0) && (this.queue.size() >= this.maxLimit)) {
                this.limit = true;
                return MAX_LIMIT;
            }
            this.queue.addAll(list);
            if (empty) {
                empty = false;
                this.emptyCond.signalAll();
            }
            return SUCCESS;
        } finally {
            lock.unlock();
        }
    }

    public long waitAvailable(int timeout) throws InterruptedException {
        long nanos = TimeUnit.MILLISECONDS.toNanos(timeout);
        if (limit) {
            lock.lock();
            try {
                if (nanos <= 0l) {
                    return -1;
                }
                if ((this.maxLimit > 0) && (this.queue.size() >= this.maxLimit)) {
                    this.limit = true;
                    return this.available.awaitNanos(nanos);
                } else {
                    return nanos;
                }

            } finally {
                lock.unlock();
            }
        } else {
            return nanos;
        }
    }

    public boolean isMaxLimit() {
        lock.lock();
        try {
            if (this.maxLimit > 0) {
                return this.queue.size() >= this.maxLimit;
            }
            return false;
        } finally {
            lock.unlock();
        }
    }

    public T dequeue() throws InterruptedException {
        lock.lock();
        try {
            if (this.queue.isEmpty()) {
                empty = true;
                this.emptyCond.await(MAX_WAIT_DEQUEUE, TimeUnit.MILLISECONDS);
            }
            if (this.limit) {
                this.limit = false;
                this.available.signalAll();
            }
            return this.queue.poll();
        } finally {
            lock.unlock();
        }
    }

    public ArrayList<T> dequeue(int numberRecord) throws InterruptedException {

        lock.lock();
        try {
            if (this.queue.isEmpty()) {
                empty = true;
                this.emptyCond.await(MAX_WAIT_DEQUEUE, TimeUnit.MILLISECONDS);
            }
            int max = numberRecord;
            if (max > this.queue.size()) {
                max = this.queue.size();
            }
            ArrayList list = new ArrayList();
            for (int i = 0; i < max; i++) {
                list.add(this.queue.poll());
            }

            if (this.limit) {
                this.limit = false;
                this.available.signalAll();
            }
            return list;
        } finally {
            lock.unlock();
        }
    }

    public long size() {

        lock.lock();
        try {
            return queue.size();
        } finally {
            lock.unlock();
        }

    }

    public boolean isEmpty() {

        lock.lock();
        try {
            return queue.isEmpty();
        } finally {
            lock.unlock();
        }
    }

    public int enqueueWait(T object) throws InterruptedException {
        lock.lock();
        try {
            if ((this.maxLimit > 0) && (this.queue.size() >= this.maxLimit)) {
                this.limit = true;
                this.available.await(0, TimeUnit.MILLISECONDS);
            }
            this.queue.add(object);
            this.available.signalAll();
            return SUCCESS;
        } finally {
            lock.unlock();
        }
    }

    public boolean isOverThreshold() {
        return limit;
    }

    public boolean isStopEnqueue() {
        return stop;
    }

    public void setStopEnqueue(boolean isStop) {
        this.stop = isStop;
    }

    public T dequeueNotify() throws InterruptedException {
        return dequeue();
    }

    public List<T> dequeueList(int numberRecord) throws InterruptedException {
        return dequeue(numberRecord);
    }
}