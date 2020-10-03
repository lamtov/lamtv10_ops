/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package akkatool;

import akkatool.*;
import java.text.DecimalFormat;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicLong;
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.ReentrantLock;

/**
 *
 * @author thuanlk
 */
public class Statistic {

    String nameString;

    public Statistic(String nameString) {
        this.nameString = nameString;
    }

    AtomicLong totalReceive = new AtomicLong();
    AtomicLong totalTime = new AtomicLong();

    AtomicLong currentMsg = new AtomicLong();
    AtomicLong currentTime = new AtomicLong();
    AtomicLong currentSend = new AtomicLong();

    long maxRestime = 0;
    double avgResTime = 0;

    long start = System.currentTimeMillis() - 1;

    int maxTps = Integer.getInteger("tps", 1000000);
    int logInterval = Integer.getInteger("logInterval", 1000);

    private ReentrantLock lock = new ReentrantLock();
    private Condition cond = lock.newCondition();
    private DecimalFormat fm = new DecimalFormat("##.##");

    public void update(long restime) {
        long tm = totalReceive.incrementAndGet();
        totalTime.addAndGet(restime);

        long cm = currentMsg.incrementAndGet();
        long ct = currentTime.addAndGet(restime);

        if (maxRestime < restime) {
            maxRestime = restime;
        }

        long current = System.currentTimeMillis();
        double currentTps = cm * 1000.0 / (current - start);
        while (currentTps > maxTps) {
            lock.lock();
            try {
                cond.await(1, TimeUnit.MILLISECONDS);
            } catch (Exception e) {
            } finally {
                lock.unlock();
            }
            current = System.currentTimeMillis();
            currentTps = cm * 1000.0 / (current - start);
        }

        if (current - start > logInterval) {
            lock.lock();
            try {
                if (current - start > logInterval) {
                    double avgTime = ct * 1.0 / cm;
                    System.out.println(nameString + " All: " + totalReceive.get()
                            + " AvgTime: " + fm.format(totalTime.get() / totalReceive.get())
                            + " Current: " + cm
                            + " AvgTime: " + fm.format(avgTime)
                            + " CurrentTps: " + fm.format(currentTps)
                            + " MaxResTime: " + maxRestime
                    );

                    maxRestime = 0;
                    currentMsg.set(0);
                    currentTime.set(0);
                    start = current;
                }
            } finally {
                lock.unlock();
            }
        }
    }

    long markTime = System.currentTimeMillis() - 1;

    public void countTPSSend() {
        long msg = currentSend.incrementAndGet();

        long current = System.currentTimeMillis();
        double currentTps = msg * 1000.0 / (current - markTime);
        while (currentTps > maxTps) {
            lock.lock();
            try {
                cond.await(1, TimeUnit.MILLISECONDS);
            } catch (Exception e) {
            } finally {
                lock.unlock();
            }
            current = System.currentTimeMillis();
            currentTps = msg * 1000.0 / (current - markTime);
        }

        if (current - markTime > logInterval) {
            lock.lock();
            try {
                if (current - markTime > logInterval) {
                    System.out.println(nameString + " All Send: " + msg + " CurrentTpsSend: " + fm.format(currentTps)
                    );

                    currentSend.set(0);
                    markTime = current;
                }
            } finally {
                lock.unlock();
            }
        }
    }
}
