package cmd

import (
	"fmt"

	"github.com/spf13/cobra"
)

var removeCmd = &cobra.Command{
	Use:   "remove",
	Short: "Remove a worktree",
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println("Running remove command")
	},
}

func init() {
	rootCmd.AddCommand(removeCmd)
}
