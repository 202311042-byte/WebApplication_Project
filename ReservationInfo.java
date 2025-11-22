package aupark;

public class ReservationInfo {
    private String spotId;
    private String startTime;
    private String duration;

    public ReservationInfo(String spotId, String startTime, String duration) {
        this.spotId = spotId;
        this.startTime = startTime;
        this.duration = duration;
    }

    public String getSpotId() {
        return spotId;
    }

    public String getStartTime() {
        return startTime;
    }

    public String getDuration() {
        return duration;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }
}
