package com.messbill.Service;

import java.time.LocalDate;
import java.util.List;

import com.messbill.Entity.ActivityLog;
import com.messbill.Repository.ActivityRepository;

public class ActivityService {

    private ActivityRepository activityRepository = new ActivityRepository();

    public void saveActivity(String activityName, String status) {
        ActivityLog activityLog = new ActivityLog();
        activityLog.setActivityDate(LocalDate.now());
        activityLog.setActivityName(activityName);
        activityLog.setStatus(status);

        activityRepository.saveActivity(activityLog);
    }

    public List<ActivityLog> getLatestActivities() {
        return activityRepository.getLatestActivities();
    }
}