package telemetry

import (
	"time"
)

// Config holds telemetry configuration
type Config struct {
	// Disable telemetry collection if set to true
	Disabled bool
	// Endpoint to send telemetry data to
	Endpoint string
	// Interval between telemetry data collection
	Interval time.Duration
	// quantumreasoningVersion represents the current version of quantumreasoning
	quantumreasoningVersion string
}

// DefaultConfig returns default telemetry configuration
func DefaultConfig() *Config {
	return &Config{
		Disabled:         false,
		Endpoint:         "https://telemetry.quantumreasoning.io",
		Interval:         15 * time.Minute,
		quantumreasoningVersion: "unknown",
	}
}
